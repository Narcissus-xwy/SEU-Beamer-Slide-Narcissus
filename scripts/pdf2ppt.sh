#!/usr/bin/env bash
# SEU-Beamer-Slide-Narcissus PDF 转 PPTX (Linux/macOS)
#
# 依赖：python pdf2ppt.py + pymupdf + python-pptx
#
# 用法：
#   bash pdf2ppt.sh                    # 交互模式，输入 .pdf 路径
#   bash pdf2ppt.sh mytalk.pdf         # 直接指定文件
#   bash pdf2ppt.sh mytalk.pdf --dpi 300  # 指定 DPI

set -e

cd "$(dirname "$0")/.."

PYTHON=$(command -v python3 || command -v python)
if [ -z "$PYTHON" ]; then
    echo "[错误] 未找到 Python，请先安装: sudo apt install python3"
    exit 1
fi

PDFFILE=""
DPI=1200

# 解析命令行参数
if [ $# -ge 1 ]; then
    PDFFILE="$1"
    shift
    while [ $# -gt 0 ]; do
        case "$1" in
            --dpi) DPI="$2"; shift 2 ;;
            *) echo "未知参数: $1"; exit 1 ;;
        esac
    done
fi

# 交互模式
if [ -z "$PDFFILE" ]; then
    echo "========================================"
    echo "  SEU-Beamer-Slide-Narcissus"
    echo "  PDF 转 PPTX (${DPI} DPI)"
    echo "========================================"
    echo ""
    echo "PDF 文件默认在 out/ 目录下"
    echo ""

    read -r -p "请输入 .pdf 文件路径（直接回车退出）： " PDFFILE
    if [ -z "$PDFFILE" ]; then
        exit 0
    fi

    read -r -p "渲染 DPI（默认 ${DPI}）： " input_dpi
    if [ -n "$input_dpi" ]; then
        DPI="$input_dpi"
    fi
fi

echo ""
echo "正在转换：${PDFFILE}"
echo "DPI：${DPI}"
echo ""

SCRIPT_DIR="$(dirname "$0")"
if "$PYTHON" "$SCRIPT_DIR/pdf2ppt.py" "$PDFFILE" --dpi "$DPI"; then
    echo ""
    echo "========================================"
    echo "  转换完成！"
    echo "========================================"
else
    echo ""
    echo "[错误] 转换失败"
    exit 1
fi
