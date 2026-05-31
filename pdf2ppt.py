"""PDF to PPTX converter for SEU-Beamer-Slide-Narcissus.

Usage:
    python pdf2ppt.py <path-to-pdf> [--dpi 300]

Or called from pdf2ppt.bat (double-click).
"""
import sys
import os
import argparse
from pathlib import Path

import fitz  # PyMuPDF
from pptx import Presentation
from pptx.util import Inches
import io


PDF_BASE_DPI = 72


def pdf_to_pptx(pdf_path: str, dpi: int = 300) -> str:
    pdf_path = Path(pdf_path)
    if not pdf_path.exists():
        raise FileNotFoundError(f"文件不存在: {pdf_path}")

    if pdf_path.suffix.lower() != ".pdf":
        pdf_path = pdf_path.with_suffix(".pdf")
        if not pdf_path.exists():
            raise FileNotFoundError(f"文件不存在: {pdf_path}")

    out_path = pdf_path.with_suffix(".pptx")
    zoom = dpi / PDF_BASE_DPI

    doc = fitz.open(str(pdf_path))
    total = doc.page_count
    if total == 0:
        doc.close()
        raise ValueError("PDF 文件为空（0 页）")

    prs = Presentation()
    prs.slide_width = Inches(13.333)
    prs.slide_height = Inches(7.5)

    blank = prs.slide_layouts[6]

    for i in range(total):
        page = doc[i]
        mat = fitz.Matrix(zoom, zoom)
        pix = page.get_pixmap(matrix=mat)
        img_bytes = pix.tobytes("png")

        slide = prs.slides.add_slide(blank)
        for ph in list(slide.placeholders):
            ph.element.getparent().remove(ph.element)

        slide.shapes.add_picture(io.BytesIO(img_bytes), 0, 0, prs.slide_width, prs.slide_height)

    doc.close()
    prs.save(str(out_path))
    return str(out_path)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PDF 转 PPTX 工具")
    parser.add_argument("pdf", help="PDF 文件路径")
    parser.add_argument("--dpi", type=int, default=300,
                        help="渲染分辨率（默认 300 DPI，论文级质量）")
    args = parser.parse_args()

    pdf_arg = args.pdf.strip('"')
    try:
        result = pdf_to_pptx(pdf_arg, dpi=args.dpi)
        size_kb = os.path.getsize(result) / 1024
        print(f"\n转换完成！")
        print(f"DPI:     {args.dpi}")
        print(f"输出:    {result}")
        print(f"大小:    {round(size_kb / 1024, 1)} MB")
    except Exception as e:
        print(f"\n[错误] {e}")
        sys.exit(1)
