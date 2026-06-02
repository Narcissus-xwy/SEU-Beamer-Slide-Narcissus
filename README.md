# SEU-Beamer-Slide-Narcissus

东南大学 Beamer 幻灯片模板 — **简洁优化版**

基于 [SEU-Beamer-Slide](https://github.com/Narcissus-xwy/SEU-Beamer-Slide) 优化而来，主要改进：

- **正文页纯白背景**，仅标题页保留 SEU 水印，更适合学术报告投影
- **内置 CJK 中文支持**（Microsoft YaHei），开箱即用
- **黑色版 Logo** 适配白底风格
- **统一浅绿色配色**，顶边底边色调一致
- **缩小顶边字号**，节省垂直空间

---

## 目录

- [零、快速开始](#零快速开始)
- [一、这个模板是什么？](#一这个模板是什么)
- [二、文件结构详解](#二文件结构详解)
- [三、编译方式](#三编译方式)
- [四、编译原理：从代码到 PDF](#四编译原理从代码到-pdf)
- [五、安装指南](#五安装指南)
- [六、快速上手：从零写第一份幻灯片(#六快速上手从零写第一份幻灯片)
- [七、插图指南](#七插图指南)
- [八、FAQ 常见问题](#八faq-常见问题)
- [许可证](#许可证)

---

## 零、快速开始

```bash
# 1. 克隆
git clone https://github.com/Narcissus-xwy/SEU-Beamer-Slide-Narcissus.git
cd SEU-Beamer-Slide-Narcissus

# 2. 安装依赖（根据你的平台）
bash install.sh          # Linux / macOS
# 或双击 install.bat    # Windows

# 3. 编译 PDF
bash make.sh             # Linux / macOS
# 或双击 make.bat        # Windows

# 4. 打开 out/example_clean.pdf 查看效果
```

---

## 一、这个模板是什么？

这是一个 **东南大学主题的 Beamer 幻灯片模板**。你只需要：

1. 写一个 `.tex` 文件（纯文本，类似写代码）
2. 用 `xelatex` 编译器运行它
3. 得到一份带有东南大学校徽、绿色主题色、专业排版的 **PDF 幻灯片**

**不需要 PowerPoint，不需要 Keynote，不需要手动调整排版。**

整个系统的上下游关系：

```
你写 .tex 文件  ──→  xelatex 编译器  ──→  输出 .pdf 幻灯片
                        ↑
                  依赖这些文件：
                   ├── seu_clean.sty  (样式规则)
                  ├── source/*.png   (校徽、背景图)
                  └── fonts/*.ttf    (字体文件)
```

---

## 二、文件结构详解

```
SEU-Beamer-Slide-Narcissus/
│
├── seu_clean.sty           ★ 核心样式文件（最重要）
│                             定义整套幻灯片的视觉风格：
│                             绿色主题、白底、校徽、页眉页脚布局
│
├── source/                   图片素材
│   ├── seu_background.png    标题页的背景水印（半透明 SEU 标志）
│   ├── seu_logo_black.png    校徽（黑色版，放在白底页眉上）
│   └── seu_title_black.png  "东南大学"标题图（黑色版）
│
├── fonts/                    西文字体（Helvetica 7个变体）
│                             确保不同系统上编译结果一致
│
├── figures/                  你放图片的文件夹（目前为空，自己往里放图）
│
├── example_clean.tex         示例文档（抄作业模板）
│                             展示所有常用元素怎么写：标题页、目录、
│                             列表、分栏、表格、公式、区块……
│
├── install.sh                Linux/macOS 一键安装脚本
├── install.bat               Windows 一键安装脚本
├── make.sh                   Linux/macOS 编译脚本
├── make.bat                  Windows 编译脚本（双击运行）
├── Makefile                  通用 make 编译
├── pdf2ppt.py                PDF → PPTX 转换工具
├── pdf2ppt.bat               Windows PDF → PPTX 转换（双击运行）
├── requirements.txt          Python 依赖（pymupdf, python-pptx）
│
├── out/                      编译输出目录
├── .gitignore                Git 忽略规则（不跟踪 .aux .log 等临时文件）
├── LICENSE                   GPL-3.0 开源协议
└── README.md                 本文件
```

### `seu_clean.sty` 逐段拆解

| 行号 | 做了什么 |
|---|---|
| 5-7 | 设置中文字体为微软雅黑 |
| 14-23 | 引用 Beamer 内置的4个基础主题模块（搭积木式组合） |
| 31-54 | 微调细节：列表用圆形符号、区块加圆角、图表标题用"图/表" |
| 62-67 | **核心优化**：仅标题页显示 SEU 水印，正文页纯白背景 |
| 71 | SEU 绿主题色 `RGB(81,122,52)` |
| 76-77 | 页眉文字缩小为 7pt |
| 91-94 | 页眉+页脚统一浅绿底色 |
| 98-114 | **页脚**格式：`[作者] [日期] [标题] [页码/总页数]` |
| 116-152 | **页眉**：标题页透明占位，正文页显示 section 导航 + 标题图 + 校徽 |
| 154-194 | **帧标题**：每页顶部的绿色渐变条 + 标题文字 |

---

## 三、编译方式

写好 `.tex` 文件后，根据你的平台选择编译方式。

### Windows

双击 `make.bat`，输入文件名后回车（或直接把 `.tex` 文件拖拽到窗口）。

```
========================================
  SEU-Beamer-Slide-Narcissus 编译工具
========================================

请输入 .tex 文件路径：mytalk
```

脚本自动执行两次 `xelatex`，输出在 `out/` 目录。

### Linux / macOS

```bash
bash make.sh                    # 编译 example_clean
bash make.sh mytalk             # 编译 mytalk.tex
bash make.sh /path/to/mytalk    # 编译外部 .tex（PDF 写回原目录）
```

### PDF → PPTX 转换（可选）

```bash
pip install -r requirements.txt   # 只需一次
python pdf2ppt.py mytalk.pdf      # 转换
```

Windows 也可以双击 `pdf2ppt.bat`，拖拽 PDF 到窗口。

---

## 四、编译原理：从代码到 PDF

```
步骤1：你写 .tex 文件
   \documentclass{beamer}
   \usepackage{seu_clean}
   \title{...}
   \begin{document} ... \end{document}

步骤2：在终端运行
   xelatex myfile.tex      # Windows
   tectonic myfile.tex      # Linux / macOS
   ─ 编译器读取 .tex
   ─ 遇到 \usepackage{seu_clean} → 读取 seu_clean.sty
   ─ 遇到 \includegraphics → 读取 png 图片
   ─ 遇到 xeCJK → 处理中文
   ─ 输出 myfile.pdf + 一堆临时文件（.aux, .log, .nav...）

步骤3：再编译一次（关键！）
   xelatex myfile.tex
   ─ 这次读取 .nav .toc 等辅助文件
   ─ 生成正确的目录和页码

步骤4：得到最终的 myfile.pdf
```

**为什么必须编译两次？**

第一次编译生成辅助文件（`.toc` 目录信息、`.nav` 导航信息、`.snm` 帧信息），第二次编译读取这些文件，才能生成正确的目录、页码和导航结构。

---

## 五、安装指南

### Linux / macOS

```bash
bash install.sh
```

自动完成：
1. 安装 **Tectonic**（轻量 LaTeX 编译器，~30MB 静态二进制）
2. 下载并安装 **文源字体**（WenYuan Sans/Serif SC，支持斜体）
3. 安装 **Python 依赖**（pymupdf + python-pptx）

### Windows

双击 `install.bat`，脚本会：
1. 检查 `xelatex` 是否已安装（如未安装，提示下载 TeX Live / MiKTeX）
2. 安装 Python 依赖（`pip install -r requirements.txt`）

> 文源字体适用于 Linux，Windows 使用系统自带的 **Microsoft YaHei**，无需额外安装。

---

## 六、快速上手：从零写第一份幻灯片

```latex
% 1. 新建一个 .tex 文件（比如 mytalk.tex）
% 2. 把下面的框架复制进去：

% !TeX program = xelatex
\documentclass[aspectratio=169, 11pt]{beamer}
\usepackage[UTF8]{ctex}                          % 中文支持
\usepackage{seu_clean}                           % SEU 样式
\usepackage{graphicx}                            % 插图
\usepackage{booktabs}                            % 漂亮表格

\title[短标题]{我的论文答辩}                      % [页脚用]{封面用}
\subtitle{副标题}
\author[张三]{张三 \\ 东南大学}
\institute{东南大学生命科学学院}
\date{\today}

\begin{document}

% 封面
\begin{frame}
  \titlepage
\end{frame}

% 目录
\begin{frame}{目录}
  \tableofcontents
\end{frame}

\section{引言}
\begin{frame}{研究背景}
  \begin{itemize}
    \item 第一点
    \item 第二点
  \end{itemize}
\end{frame}

\section{方法}
\begin{frame}{实验设计}
  正文内容...
\end{frame}

\section{结果}
\begin{frame}{主要发现}
  \begin{block}{关键结果}
    用 block 强调重要信息
  \end{block}
\end{frame}

\section{结论}
\begin{frame}{总结}
  感谢聆听
\end{frame}

\end{document}

% 3. 编译（二选一）：
%    双击 make.bat，输入 mytalk（或拖拽文件）→ 自动编译两次
%    或手动：xelatex mytalk.tex 再执行一次
```

### 常用元素速查

**三种区块：**
```latex
\begin{block}{普通区块}   一般重要信息 \end{block}
\begin{alertblock}{警告}  关键警告或注意事项 \end{alertblock}
\begin{exampleblock}{示例} 案例或直觉解释 \end{exampleblock}
```

**列表：**
```latex
\begin{itemize}   \item 无序列表项 \end{itemize}
\begin{enumerate} \item 有序列表项 \end{enumerate}
```

**双栏布局：**
```latex
\begin{columns}
\column{0.48\textwidth}  左栏内容
\column{0.48\textwidth}  右栏内容
\end{columns}
```

**表格（booktabs 规范，禁止竖线）：**
```latex
\begin{tabular}{lccc}
\toprule
方法 & 准确率 & 召回率 & F1 \\
\midrule
方法A & 89\% & 87\% & 88.4 \\
\bottomrule
\end{tabular}
```

**数学公式：**
```latex
\begin{equation}
  \mathcal{L}(\theta) = -\sum_{i=1}^{n} \log P(y_i|x_i; \theta)
\end{equation}
```

---

## 七、插图指南

### 7.1 把图片放进 `figures/` 文件夹

### 7.2 在 .tex 里插入图片

### 7.3 控制图片大小的参数

### 7.4 双栏图文混排

### 7.5 多张图并排

### 7.6 图片格式建议

---

## 八、FAQ 常见问题

**Q: 编译报错 "File not found"？**
A: 检查图片路径。如果用 `\graphicspath{{figures/}}`，直接写文件名 `{my_diagram.png}`；如果没设路径，要写相对路径 `{figures/my_diagram.png}`。

**Q: 图片太大跑出页面了？**
A: 永远用 `width=` 或 `scale=` 控制大小，不要直接用原图尺寸。最安全的写法：`width=\textwidth, height=0.75\textheight, keepaspectratio`。

**Q: 为什么目录/页码不对？**
A: 你只编译了一次。LaTeX 需要**编译两次**才能生成正确的目录和交叉引用。

**Q: 为什么字没显示出来？**
A: 确认你的编辑器/命令行用的是 `xelatex`（而不是 `pdflatex`），因为中文支持需要 `xelatex`。

**Q: 我想换颜色？**
A: 修改 `seu_clean.sty` 第71行的 RGB 值。也可以加一行 `\usecolortheme[RGB={你的颜色}]{structure}`。

**Q: 可以在 Overleaf 上用吗？**
A: 可以。把整个文件夹上传到 Overleaf，编译器选 **XeLaTeX**，然后按正常方式写。

**Q: 不需要 `figures/` 文件夹也可以放图吗？**
A: 可以。图片可以和 `.tex` 文件放同一目录，或者写完整相对路径。但用 `figures/` 统一管理更整洁。

---

## 许可证

GPL-3.0 © Narcissus-xwy
