#!/usr/bin/env bash
# SEU-Beamer-Slide-Narcissus 编译脚本 (Linux/macOS)
#
# 依赖：tectonic（替代 xelatex）
#   安装：https://tectonic-typesetting.github.io/book/latest/installation/
#
# 用法：
#   bash make.sh                    # 编译 example_clean
#   bash make.sh mytalk             # 编译 mytalk.tex（项目目录内）
#   bash make.sh path/to/talk.tex   # 编译外部 .tex（PDF 写回原目录）

set -e

# 切换到项目根目录（脚本在 scripts/ 子目录），使 .sty 能被找到
cd "$(dirname "$0")/.."

# Add local bin to PATH (common install location for tectonic)
export PATH="$HOME/.local/bin:$PATH"

INPUT_ARG="${1:-example_clean}"
INPUT_ARG="${INPUT_ARG%.tex}"   # 去掉 .tex 后缀
INPUT_ARG="${INPUT_ARG#\"}"     # 去除引号
INPUT_ARG="${INPUT_ARG%\"}"

# 解析输入文件路径（realpath 前确认文件存在，避免报错）
if [ ! -f "${INPUT_ARG}.tex" ]; then
    if [ -f "examples/${INPUT_ARG}.tex" ]; then
        INPUT_ARG="examples/${INPUT_ARG}"
    else
        echo "错误：找不到文件 ${INPUT_ARG}.tex"
        echo "      也在 examples/ 目录下查找过，未找到。"
        exit 1
    fi
fi
INPUT_FILE="$(realpath "${INPUT_ARG}.tex")"

INPUT_DIR="$(dirname "$INPUT_FILE")"
INPUT_NAME="$(basename "$INPUT_FILE" .tex)"

# 如果 .tex 不在项目目录，复制到项目目录编译（tectonic 不从 CWD 搜索 .sty）
if [ "$INPUT_DIR" != "$(pwd)" ]; then
    echo "检测到外部文件，复制到项目目录编译..."
    cp "$INPUT_FILE" "${INPUT_NAME}.tex"
    TEXFILE="${INPUT_NAME}"
    COPY_MODE=true
else
    TEXFILE="$INPUT_NAME"
    COPY_MODE=false
fi

mkdir -p out

echo "正在编译：${TEXFILE}.tex"
echo "输出目录：$(pwd)/out/"

tectonic -X compile -r 2 -o out "${TEXFILE}.tex"

# 如果是外部文件，将 PDF 写回原目录
if [ "$COPY_MODE" = true ]; then
    echo "将 PDF 复制回：${INPUT_DIR}/"
    cp "out/${TEXFILE}.pdf" "${INPUT_DIR}/${INPUT_NAME}.pdf"
    rm -f "${TEXFILE}.tex"
fi

echo ""
echo "========================================"
echo "  编译完成！"
if [ "$COPY_MODE" = true ]; then
    echo "  PDF 文件：${INPUT_DIR}/${INPUT_NAME}.pdf"
else
    echo "  PDF 文件：$(pwd)/out/${TEXFILE}.pdf"
fi
echo "========================================"
