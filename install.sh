#!/usr/bin/env bash
# SEU-Beamer-Slide-Narcissus 一键安装脚本 (Linux/macOS)
#
# 自动完成：
#   1. 安装 Tectonic（LaTeX 编译器）
#   2. 下载并安装文源字体（WenYuan Sans/Serif SC）
#   3. 安装 Python 依赖（pdf2ppt 工具）
#
# 用法：
#   bash install.sh

set -e

echo "========================================"
echo "  SEU-Beamer-Slide-Narcissus 安装脚本"
echo "  Linux / macOS"
echo "========================================"
echo ""

# ─── 1. 安装 Tectonic ───────────────────────────────────────
install_tectonic() {
    if command -v tectonic &>/dev/null; then
        echo "[✔] Tectonic 已安装: $(tectonic --version)"
        return
    fi

    echo "[1/3] 正在安装 Tectonic ..."

    # 检测架构
    ARCH="x86_64"
    OS="unknown-linux-musl"
    case "$(uname -s)" in
        Linux)  OS="unknown-linux-musl" ;;
        Darwin) OS="apple-darwin"; ARCH="x86_64" ;;
    esac
    case "$(uname -m)" in
        aarch64|arm64) ARCH="aarch64" ;;
    esac

    # 获取最新版本号
    echo "      获取最新版本..."
    VERSION=$(curl -sI "https://github.com/tectonic-typesetting/tectonic/releases/latest" 2>/dev/null \
              | grep -i "^location:" \
              | sed 's/.*tectonic@//;s/\r//' \
              || echo "0.16.9")

    FILENAME="tectonic-${VERSION}-${ARCH}-${OS}.tar.gz"
    URL="https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic@${VERSION}/${FILENAME}"

    echo "      下载 ${FILENAME} ..."
    curl -fSL -o /tmp/tectonic.tar.gz "$URL"

    echo "      解压并安装到 ~/.local/bin/ ..."
    mkdir -p ~/.local/bin
    tar xzf /tmp/tectonic.tar.gz -C ~/.local/bin/ 2>/dev/null || {
        # 如果 tar 直接解压出二进制，可能在当前目录
        tar xzf /tmp/tectonic.tar.gz
        cp tectonic ~/.local/bin/tectonic 2>/dev/null || true
    }
    chmod +x ~/.local/bin/tectonic 2>/dev/null || true
    rm -f /tmp/tectonic.tar.gz tectonic 2>/dev/null

    export PATH="$HOME/.local/bin:$PATH"
    if command -v tectonic &>/dev/null; then
        echo "[✔] Tectonic 安装成功: $(tectonic --version)"
    else
        echo "[!] Tectonic 安装失败，请手动安装"
        echo "    https://github.com/tectonic-typesetting/tectonic/releases"
    fi
}

# ─── 2. 安装 WenYuan 字体 ───────────────────────────────────
install_fonts() {
    echo ""
    echo "[2/3] 正在安装文源字体 ..."

    # 检查是否已安装
    if fc-match "WenYuan Sans SC" 2>/dev/null | grep -q "WenYuan"; then
        echo "[✔] 文源黑体已安装"
    fi
    if fc-match "WenYuan Serif SC" 2>/dev/null | grep -q "WenYuan"; then
        echo "[✔] 文源宋体已安装"
    fi
    if fc-match "WenYuan Sans SC" 2>/dev/null | grep -q "WenYuan" \
       && fc-match "WenYuan Serif SC" 2>/dev/null | grep -q "WenYuan"; then
        echo "[✔] 文源字体已完整安装，跳过"
        return
    fi

    # 获取最新版本号
    FONT_VERSION=$(curl -sI "https://github.com/takushun-wu/WenYuanFonts/releases/latest" 2>/dev/null \
                   | grep -i "^location:" \
                   | sed 's/.*releases\/tag\///;s/\r//' \
                   || echo "2026.5.22")
    echo "      字体版本: ${FONT_VERSION}"

    mkdir -p ~/.fonts
    pushd /tmp >/dev/null

    # 下载黑体
    if [ ! -f WenYuanSansSC-OTF.7z ]; then
        echo "      下载文源黑体 (Sans) ..."
        curl -fSL -o WenYuanSansSC-OTF.7z \
            "https://github.com/takushun-wu/WenYuanFonts/releases/download/${FONT_VERSION}/WenYuanSansSC-OTF.7z"
    fi

    # 下载宋体
    if [ ! -f WenYuanSerifSC-OTF.7z ]; then
        echo "      下载文源宋体 (Serif) ..."
        curl -fSL -o WenYuanSerifSC-OTF.7z \
            "https://github.com/takushun-wu/WenYuanFonts/releases/download/${FONT_VERSION}/WenYuanSerifSC-OTF.7z"
    fi

    # 解压（自动安装 py7zr，备选 7z）
    extract_7z() {
        local archive="$1"
        # 尝试用 Python py7zr
        if python3 -c "import py7zr; py7zr.SevenZipFile('${archive}').extractall('${HOME}/.fonts/')" 2>/dev/null; then
            return 0
        fi
        # 安装 py7zr 再试
        echo "      安装 py7zr 用于解压字体 ..."
        pip3 install py7zr -q 2>/dev/null || pip install py7zr -q 2>/dev/null
        if python3 -c "import py7zr; py7zr.SevenZipFile('${archive}').extractall('${HOME}/.fonts/')" 2>/dev/null; then
            return 0
        fi
        # 备选：系统 7z
        if command -v 7z &>/dev/null; then
            7z x "${archive}" -o"${HOME}/.fonts/" -y >/dev/null
            return 0
        fi
        echo "[!] 解压失败: ${archive}"
        echo "    请手动安装: pip install py7zr"
        return 1
    }

    extract_7z WenYuanSansSC-OTF.7z
    extract_7z WenYuanSerifSC-OTF.7z

    # 刷新字体缓存
    echo "      刷新字体缓存 ..."
    fc-cache -fv 2>&1 | tail -1

    popd >/dev/null

    # 验证
    echo "      验证字体 ..."
    fc-match "WenYuan Sans SC"
    fc-match "WenYuan Serif SC"
    echo "[✔] 文源字体安装完成"
}

# ─── 3. 安装 Python 依赖 ────────────────────────────────────
install_python() {
    echo ""
    echo "[3/3] 正在安装 Python 依赖 ..."

    cd "$PROJECT_DIR"

    if [ ! -f requirements.txt ]; then
        echo "[!] requirements.txt 不存在，跳过"
        return
    fi

    pip3 install -r requirements.txt -q 2>/dev/null || pip install -r requirements.txt -q 2>/dev/null || {
        echo "[!] pip install 失败，请手动执行: pip install -r requirements.txt"
        return
    }
    echo "[✔] Python 依赖安装完成"
}

# ─── 执行 ────────────────────────────────────────────────────
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

install_tectonic
install_fonts
install_python

echo ""
echo "========================================"
echo "  安装完成！"
echo ""
echo "  使用方法："
echo "    cd SEU-Beamer-Slide-Narcissus"
echo "    bash make.sh              # 编译 example_clean"
echo "    bash make.sh mytalk       # 编译自定义文件"
echo "========================================"
