# SEU-Beamer-Slide-Narcissus

东南大学 Beamer 幻灯片模板 — **简洁优化版**

基于 [SEU-Beamer-Slide](https://github.com/Narcissus-xwy/SEU-Beamer-Slide) 优化而来，主要改进：

- **正文页纯白背景**，仅标题页保留 SEU 水印，更适合学术报告投影
- **内置 CJK 中文支持**（Microsoft YaHei），开箱即用
- **黑色版 Logo** 适配白底风格
- **统一浅绿色配色**，顶边底边色调一致
- **缩小顶边字号**，节省垂直空间

## 使用方法

### 方式一：本地编译

```bash
# Windows: 双击 make.bat
make.bat

# macOS / Linux:
bash make.sh
# 或
make
```

### 方式二：手动编译

```bash
xelatex example_clean
xelatex example_clean
```

> 必须编译两次，以确保目录、页码、交叉引用正确生成。

## 文件结构

```
SEU-Beamer-Slide-Narcissus/
├── seu-clean.sty           # ★ 样式文件（核心）
├── source/
│   ├── seu_background.png  #   SEU 背景水印
│   ├── seu_logo_black.png  #   SEU Logo（黑色版）
│   └── seu_title_black.png #   SEU 标题图（黑色版）
├── fonts/
│   └── Helvetica*          #   西文字体
├── example_clean.tex       #   示例文件
├── Makefile                #   Unix 编译
├── make.bat                #   Windows 编译
├── make.sh                 #   Shell 编译
├── .gitignore
├── LICENSE                 #   GPL-3.0
└── README.md
```

## 在自己的文档中使用

```latex
% !TeX program = xelatex
\documentclass[aspectratio=169, 11pt]{beamer}
\usepackage[UTF8]{ctex}
\usepackage{seu-clean}

\title[短标题]{完整标题}
\subtitle{副标题}
\author[作者缩写]{作者姓名}
\institute{机构名称}
\date{\today}

\begin{document}
\begin{frame}
  \titlepage
\end{frame}

\begin{frame}{目录}
  \tableofcontents
\end{frame}

\section{章节}
\begin{frame}{帧标题}
  正文内容
\end{frame}
\end{document}
```

## 许可证

GPL-3.0 © Narcissus-xwy
