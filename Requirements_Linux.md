# Linux 环境依赖

## 1. Tectonic（LaTeX 编译器）

替代 Windows 上的 xelatex，超轻量（~30MB 单静态二进制），自动下载包。

**安装方式**：

```bash
# 从 GitHub Releases 下载最新版 musl 静态二进制
# 查看最新版本号：https://github.com/tectonic-typesetting/tectonic/releases
curl -fSL -o tectonic.tar.gz \
  "https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic@0.16.9/tectonic-0.16.9-x86_64-unknown-linux-musl.tar.gz"
tar xzf tectonic.tar.gz
mkdir -p ~/.local/bin
cp tectonic ~/.local/bin/tectonic
chmod +x ~/.local/bin/tectonic
```

确保 `~/.local/bin/` 在 PATH 中（make.sh 会自动添加）。

**首次编译**时会自动下载所有依赖包，需联网。

## 2. WenYuan 字体（文源宋体 + 文源黑体）

用于中文排版，支持斜体（通过 AutoFakeSlant）。

**下载**：从 [GitHub Releases](https://github.com/takushun-wu/WenYuanFonts/releases) 获取静态 OTF 版

```bash
# 下载黑体（Sans）和宋体（Serif）的 OTF 压缩包
# 请将 <版本号> 替换为最新 release tag（如 2026.5.22）
curl -fSL -o WenYuanSansSC-OTF.7z \
  "https://github.com/takushun-wu/WenYuanFonts/releases/download/<版本号>/WenYuanSansSC-OTF.7z"
curl -fSL -o WenYuanSerifSC-OTF.7z \
  "https://github.com/takushun-wu/WenYuanFonts/releases/download/<版本号>/WenYuanSerifSC-OTF.7z"
```

**安装**：

```bash
# 方法 A：使用 p7zip（需先安装：sudo apt install p7zip-full）
7z x WenYuanSansSC-OTF.7z -o~/.fonts/
7z x WenYuanSerifSC-OTF.7z -o~/.fonts/

# 方法 B：使用 Python py7zr（如已装 Python3）
pip install py7zr
python3 -c "import py7zr; py7zr.SevenZipFile('WenYuanSansSC-OTF.7z').extractall('~/.fonts/')"
python3 -c "import py7zr; py7zr.SevenZipFile('WenYuanSerifSC-OTF.7z').extractall('~/.fonts/')"

# 刷新字体缓存
fc-cache -fv

# 验证
fc-match "WenYuan Sans SC"
fc-match "WenYuan Serif SC"
```

**验证输出示例**：
```
WenYuanSansSC-Regular.otf: "WenYuan Sans SC" "Regular"
WenYuanSerifSC-Regular.otf: "WenYuan Serif SC" "Regular"
```

## 3. Python（pdf2ppt 工具）

需要 Python 3.8+。

```bash
pip install pymupdf python-pptx
```

## 4. 可选：Helvetica 字体

项目自带 `font/` 目录包含 Helvetica `.ttf`/`.otf` 文件，无需额外安装。

## 文件结构

```
SEU-Beamer-Slide-Narcissus/
├── seu_clean.sty          # 主样式（跨平台字体自动检测）
├── make.sh                # 编译脚本（Linux/macOS）
├── make.bat               # 编译脚本（Windows，仅限 cmd）
├── out/                   # 编译输出目录
├── font/                  # Helvetica 字体
└── source/                # SEU 背景/Logo 图片
```

## 使用

```bash
# 进入项目目录
cd SEU-Beamer-Slide-Narcissus

# 编译示例文件
bash make.sh

# 编译自定义文件（项目目录内）
bash make.sh mytalk

# 编译外部文件（PDF 写回原目录）
bash make.sh /path/to/mytalk
```
