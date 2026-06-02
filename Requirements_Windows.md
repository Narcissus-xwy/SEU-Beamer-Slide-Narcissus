# Windows 环境依赖

## 1. TeX 发行版（xelatex）

使用 xelatex 编译。

**推荐**：
- TeX Live（完整版，~2GB）
- MiKTeX（轻量级，按需安装包）

确保 `xelatex` 在系统 PATH 中。

## 2. Python（pdf2ppt 工具）

需要 Python 3.8+。

```bat
pip install pymupdf python-pptx
```

## 3. 中文字体

模板自动使用系统已有的 `Microsoft YaHei`（微软雅黑），无需额外安装。
如果使用 WSL/Linux 双系统，见 `Requirements_Linux.md`。

## 4. Helvetica 字体

项目自带 `font/` 目录包含 Helvetica `.ttf`/`.otf` 文件，无需额外安装。

## 文件结构

```
SEU-Beamer-Slide-Narcissus/
├── seu_clean.sty          # 主样式（跨平台字体自动检测）
├── make.bat               # 编译脚本（Windows，拖拽 .tex 即可编译）
├── make.sh                # 编译脚本（Linux/macOS）
├── pdf2ppt.bat            # PDF → PPTX 转换脚本
├── pdf2ppt.py             # PDF → PPTX 转换工具
├── Makefile               # make 构建
├── out/                   # 编译输出目录
├── font/                  # Helvetica 字体
└── source/                # SEU 背景/Logo 图片
```

## 使用

```bat
:: 编译示例文件
make.bat

:: 编译自定义文件（拖拽 .tex 到 make.bat 上）
make.bat mytalk.tex
```
