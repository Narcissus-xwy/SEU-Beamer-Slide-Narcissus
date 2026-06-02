# Linux 环境依赖

## 1. Tectonic（LaTeX 编译器）

替代 Windows 上的 xelatex，超轻量（~30MB 单静态二进制），自动下载包。

**安装方式**：

```bash
# 方法 A：官方安装脚本（推荐）
curl -fsSL https://tectonic-typesetting.github.io/install.sh | bash

# 方法 B：从 GitHub Releases 手动下载
# 下载 tectonic-*-x86_64-unknown-linux-musl.tar.gz
# 解压后将 tectonic 放到 ~/.local/bin/
```

确保 `~/.local/bin/` 在 PATH 中（make.sh 会自动添加）。

**首次编译**时会自动下载所有依赖包，需联网。

## 2. WenYuan 字体（文源宋体 + 文源黑体）

用于中文排版，支持斜体（通过 AutoFakeSlant）。

**下载**：从 GitHub Releases 获取静态 OTF 版

```
WenYuanSansSC-OTF.7z  （文源黑体 / sans / 6 个字重）
WenYuanSerifSC-OTF.7z （文源宋体 / serif / 6 个字重）
```

**安装**：

```bash
# 解压到 ~/.fonts/
7z x WenYuanSansSC-OTF.7z -o~/.fonts/
7z x WenYuanSerifSC-OTF.7z -o~/.fonts/

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
