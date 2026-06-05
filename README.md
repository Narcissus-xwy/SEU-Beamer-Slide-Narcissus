# SEU-Beamer-Slide-Narcissus

东南大学 Beamer 幻灯片模板 — **简洁优化版**

基于 [SEU-Beamer-Slide](https://github.com/Narcissus-xwy/SEU-Beamer-Slide) 优化而来，主要改进：

- **正文页纯白背景**，仅标题页保留 SEU 水印，更适合学术报告投影
- **跨平台 CJK 中文支持**：Linux 自动检测文源字体 (WenYuan)，Windows 自动使用微软雅黑 (YaHei)
- **黑色版 Logo** 适配白底风格
- **统一浅绿色/浅蓝色配色**（绿 `seu_clean_green`、蓝 `seu_clean_blue`），顶边底边色调一致
- 提供 **v1（经典）** 和 **v2（现代框式）** 两个版本，v2 可选绿色或蓝色

---

## 目录

- [零、快速开始](#零快速开始)
- [一、这个模板是什么？](#一这个模板是什么)
- [二、版本对比](#二版本对比)
- [三、文件结构详解](#三文件结构详解)
- [四、编译方式](#四编译方式)
- [五、编译原理：从代码到 PDF](#五编译原理从代码到-pdf)
- [六、安装指南](#六安装指南)
- [七、快速上手：从零写第一份幻灯片](#七快速上手从零写第一份幻灯片)
- [八、插图指南](#八插图指南)
- [九、FAQ 常见问题](#九faq-常见问题)
- [十、字体字号速查表](#十字体字号速查表)
- [许可证](#许可证)

---

## 零、快速开始

```bash
# 1. 克隆
git clone https://github.com/Narcissus-xwy/SEU-Beamer-Slide-Narcissus.git
cd SEU-Beamer-Slide-Narcissus

# 2. 安装依赖（根据你的平台）
bash scripts/install.sh      # Linux / macOS
# 或双击 scripts\install.bat  # Windows

# 3. 选择版本，编译 PDF
# v1（经典版）：
bash scripts/make.sh example_v1
# v2（框式版，绿色）：
bash scripts/make.sh example_v2
# v2（框式版，蓝色，推荐投影）：
bash scripts/make.sh example_clean

# 4. 查看生成的 PDF
#    out/example_clean.pdf  （蓝色框式版）
#    out/example_v2.pdf     （绿色框式版）
#    out/example_v1.pdf     （v1 经典版）
```

---

## 一、这个模板是什么？

这是一个 **东南大学主题的 Beamer 幻灯片模板**。你只需要：

1. 写一个 `.tex` 文件（纯文本，类似写代码）
2. 用 `xelatex` 编译器运行它
3. 得到一份带有东南大学校徽、绿色/蓝色主题色、专业排版的 **PDF 幻灯片**

**不需要 PowerPoint，不需要 Keynote，不需要手动调整排版。**

整个系统的上下游关系：

```
你写 .tex 文件  ──→  编译器  ──→  输出 .pdf 幻灯片
                      ├── Windows: xelatex
                      └── Linux:   tectonic
                        ↑
                  依赖这些文件：
                   ├── seu_clean_v1.sty          (经典版样式)
                   ├── seu_clean_green.sty        (绿色框式版样式)
                   ├── seu_clean_blue.sty         (蓝色框式版样式)
                   ├── source/*.png              (校徽、背景图)
                   └── fonts/*.ttf               (字体文件)
```

---

## 二、版本对比

### 结构对比（v1 经典 vs v2 框式）

| 特性 | v1（经典版） | v2（框式版） |
|---|---|---|
| **样式文件** | `seu_clean_v1.sty` | `seu_clean_green.sty` / `seu_clean_blue.sty` |
| **示例文件** | `example_v1.tex` | `example_v2.tex`（绿） / `example_clean.tex`（蓝） |
| **帧标题样式** | 顶部渐变底色条，标题左对齐 | 居中通栏尖角 `\fcolorbox` 框 |
| **页眉导航** | `\insertsectionnavigationhorizontal`（显示所有节） | 仅当前章节名左对齐 |
| **页眉字号** | 7pt | 12pt |
| **正文基底** | 相对（`\documentclass` 选项控制） | 相对（`\documentclass` 选项控制） |
| **标题页字号** | 相对大小 | 绝对大小（不受基字影响） |
| **目录字号** | 相对大小 | 绝对 12pt / 10pt |
| **`\plainframetitle`** | 无 | 有（目录页免框） |
| **`\RequirePackage{tikz}`** | 无 | 有（供 frametitle 模板使用） |

### 配色方案（v2 框式版）

| 配色 | 样式文件 | RGB | 说明 |
|---|---|---|---|
| 绿色 | `seu_clean_green.sty` | `(81, 122, 52)` | 原 v2 默认配色 |
| 蓝色 | `seu_clean_blue.sty` | `(52, 87, 122)` | 等深等饱和度替换，投影更清晰 |

### 如何选择

- **v1**：简洁、经典，帧标题与页眉融为一体，适合内容密集的学术报告
- **v2（绿色）**：帧标题独立框式突出，章节名在页眉左侧固定显示，适合需要清晰区分章节结构的演示
- **v2（蓝色）**：同上框式结构，蓝色调在投影时视觉效果更佳

---

## 三、文件结构详解

```
SEU-Beamer-Slide-Narcissus/
│
├── seu_clean_v1.sty        ★ v1 经典样式文件
├── seu_clean_green.sty     ★ v2 框式样式文件（绿色）
├── seu_clean_blue.sty      ★ v2 框式样式文件（蓝色）
│
├── source/                   图片素材
│   ├── seu_background.png    标题页背景水印
│   ├── seu_logo_black.png    校徽（黑色版）
│   └── seu_title_black.png  "东南大学"标题图
│
├── fonts/                    西文字体（Helvetica 7个变体）
├── figures/                  你放图片的文件夹
│
├── examples/                 示例文档
│   ├── example_v1.tex        v1 示例
│   ├── example_v2.tex        v2 框式版（绿色）示例
│   └── example_clean.tex     v2 框式版（蓝色）示例
│
├── scripts/                  工具脚本
│   ├── make.sh / make.bat    编译脚本（Linux / Windows）
│   ├── Makefile              通用 make 编译
│   ├── install.sh / install.bat  安装脚本
│   ├── pdf2ppt.py / .sh / .bat   PDF → PPTX 转换
│   └── requirements.txt      Python 依赖
│
├── out/                      编译输出目录
├── .gitignore
├── LICENSE
└── README.md
```

### 版本切换

使用哪个版本，就在 `.tex` 文件导言区引用对应的 `.sty` 文件：

```latex
\usepackage{seu_clean_v1}        % v1 经典版（绿色）
% 或
\usepackage{seu_clean_green}     % v2 框式版（绿色）
% 或
\usepackage{seu_clean_blue}      % v2 框式版（蓝色，推荐投影）
```

---

## 四、编译方式

写好 `.tex` 文件后，根据你的平台选择编译方式。

### Windows

双击 `scripts\make.bat`，输入文件名后回车（或直接把 `.tex` 文件拖拽到窗口）。

```
========================================
  SEU-Beamer-Slide-Narcissus 编译工具
========================================

请输入 .tex 文件路径：example_clean
```

脚本自动切换到项目根目录，执行两次 `xelatex`，输出在 `out/` 目录。

### Linux / macOS

```bash
# 示例文件自动在 examples/ 下查找，无需写路径
bash scripts/make.sh                    # 编译 example_clean（蓝色框式版）
bash scripts/make.sh example_v1         # 编译 v1 示例
bash scripts/make.sh example_v2         # 编译 v2（绿色）示例
bash scripts/make.sh mytalk             # 编译自定义文件
bash scripts/make.sh /path/to/mytalk    # 编译外部 .tex（PDF 写回原目录）
```

### PDF → PPTX 转换（可选）

```bash
pip install -r scripts/requirements.txt   # 只需一次
python scripts/pdf2ppt.py mytalk.pdf      # 转换
```

快捷方式：
- **Linux / macOS**：`bash scripts/pdf2ppt.sh`（交互式，也可直接传参 `bash scripts/pdf2ppt.sh mytalk.pdf`）
- **Windows**：双击 `scripts\pdf2ppt.bat`，拖拽 PDF 到窗口

---

## 五、编译原理：从代码到 PDF

```
步骤1：你写 .tex 文件
   \documentclass{beamer}
   \usepackage{seu_clean_blue}   ← 换成 v1/绿色/蓝色
   \title{...}
   \begin{document} ... \end{document}

步骤2：在终端运行
   bash scripts/make.sh myfile  # 推荐：脚本自动处理路径
   # 或直接用编译器：
   tectonic myfile.tex       # Linux / macOS（Tectonic 自动编译两次）
   xelatex myfile.tex        # Windows（需要手动编译两次）
   ─ 编译器读取 .tex
   ─ 遇到 \usepackage{seu_clean_blue} → 读取 seu_clean_blue.sty
   ─ 遇到 \includegraphics → 读取 png 图片
   ─ 遇到 xeCJK → 处理中文
   ─ 输出 myfile.pdf + 一堆临时文件（.aux, .log, .nav...）

步骤3：Windows 用户再编译一次（关键！）
   xelatex myfile.tex
   ─ 这次读取 .nav .toc 等辅助文件
   ─ 生成正确的目录和页码
   ─ Linux/macOS 用户：Tectonic 已自动完成第二次编译，无需手动操作

步骤4：得到最终的 myfile.pdf
```

**为什么必须编译两次？**

第一次编译生成辅助文件（`.toc` 目录信息、`.nav` 导航信息、`.snm` 帧信息），第二次编译读取这些文件，才能生成正确的目录、页码和导航结构。

> **Windows（xelatex）**：需要手动编译两次，或使用 `make.bat`（自动执行两次）。
> **Linux/macOS（Tectonic）**：已自动编译两次，无需手动操作。

---

## 六、安装指南

### Linux / macOS

```bash
bash scripts/install.sh
```

自动完成：
1. 安装 **Tectonic**（轻量 LaTeX 编译器，~30MB 静态二进制）
2. 下载并安装 **文源字体**（WenYuan Sans/Serif SC，支持斜体）
3. 安装 **Python 依赖**（pymupdf + python-pptx）

### Windows

双击 `scripts\install.bat`，脚本会：
1. 检查 `xelatex` 是否已安装（如未安装，提示下载 TeX Live / MiKTeX）
2. 安装 Python 依赖（`pip install`）

> 文源字体适用于 Linux，Windows 使用系统自带的 **Microsoft YaHei**，无需额外安装。
> **注意**：文源与雅黑字面率不同，Linux 模板切到 Windows 后中文字号会偏大。建议在 `.tex` 中添加 `\setCJKsansfont{Microsoft YaHei}[Scale=0.9]` 和 `\setCJKmainfont{Microsoft YaHei}[Scale=0.9]` 保持视觉一致（见 FAQ）。

---

## 七、快速上手：从零写第一份幻灯片

```latex
% 1. 新建一个 .tex 文件（比如 mytalk.tex）
% 2. 把下面的框架复制进去：

% !TeX program = xelatex
\documentclass[aspectratio=169, 11pt]{beamer}
\usepackage[UTF8]{ctex}                          % 中文支持
\usepackage{seu_clean_blue}                      % SEU 样式（v2 框式版，蓝色）
% \usepackage{seu_clean_green}                   % 改为绿色框式版
% \usepackage{seu_clean_v1}                      % 改为 v1 经典版
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

% 目录 (v2 推荐使用 \plainframetitle 让目录页免框)
\plainframetitle         % ← 仅 v2 需要，v1 无此命令
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

% 3. 编译：
%    bash scripts/make.sh mytalk         # Linux / macOS
%    或双击 scripts\make.bat，输入 mytalk # Windows
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

## 八、插图指南

### 8.1 把图片放进 `figures/` 文件夹

### 8.2 在 .tex 里插入图片

### 8.3 控制图片大小的参数

### 8.4 双栏图文混排

### 8.5 多张图并排

### 8.6 图片格式建议

---

## 九、FAQ 常见问题

**Q: v1 / 绿色 / 蓝色 怎么切换？**
A: 修改 `.tex` 导言区的 `\usepackage`：
```latex
\usepackage{seu_clean_v1}        % 经典版（绿色）
\usepackage{seu_clean_green}     % 框式版（绿色）
\usepackage{seu_clean_blue}      % 框式版（蓝色，推荐投影）
```

**Q: 编译报错 "File not found"？**
A: 检查图片路径。如果用 `\graphicspath{{figures/}}`，直接写文件名 `{my_diagram.png}`；如果没设路径，要写相对路径 `{figures/my_diagram.png}`。

**Q: 图片太大跑出页面了？**
A: 永远用 `width=` 或 `scale=` 控制大小，不要直接用原图尺寸。最安全的写法：`width=\textwidth, height=0.75\textheight, keepaspectratio`。

**Q: 为什么目录/页码不对？**
A: 你只编译了一次。LaTeX 需要**编译两次**才能生成正确的目录和交叉引用。

**Q: 为什么字没显示出来？**
A: 确认编译器正确：
- **Windows**：用 `xelatex`（而不是 `pdflatex`），中文支持需要 xelatex。
- **Linux/macOS**：用 `tectonic`（安装脚本已自动配置）。
- 如果字体缺失，检查 `fc-list | grep WenYuan`（Linux）确认文源字体已安装。

**Q: 在 WSL（Linux）上编译的字号正常，搬到 Windows（xelatex）后中文字忽大忽小？**
A: 这是字体差异导致的。WSL 使用 **文源字体**（WenYuan），Windows 使用 **微软雅黑**（Microsoft YaHei），两者的字面率（x-height）不同，雅黑的视觉字号比文源大。

解决方法：在 `.tex` 导言区加两行，给微软雅黑一个 `Scale=0.9` 的缩放因子：
```latex
\setCJKsansfont{Microsoft YaHei}[Scale=0.9]   % 影响 \sffamily 文本
\setCJKmainfont{Microsoft YaHei}[Scale=0.9]   % 影响正文中文
```
建议加在 `\usepackage{seu_clean_*}` 之后。数值可根据实际视觉效果微调（0.85–0.95 之间）。

**Q: 我想换颜色？**
A: 修改 `seu_clean_green.sty` 或 `seu_clean_blue.sty`（或 `seu_clean_v1.sty`）第 83 行的 RGB 值。也可以加一行 `\usecolortheme[RGB={你的颜色}]{structure}`。

**Q: 可以在 Overleaf 上用吗？**
A: 可以。把整个文件夹上传到 Overleaf，编译器选 **XeLaTeX**，然后按正常方式写。注意 `.sty` 文件必须在 `.tex` 文件的同级或 TEXINPUTS 路径下。

**Q: 不需要 `figures/` 文件夹也可以放图吗？**
A: 可以。图片可以和 `.tex` 文件放同一目录，或者写完整相对路径。但用 `figures/` 统一管理更整洁。

---

## 十、字体字号速查表

### v2（框式版）预设绝对字号

| 显示位置 | 内容 | 字号 / 行距 | 控制命令 |
|---|---|---|---|
| **帧标题框** | 帧标题（居中尖角框内） | 16pt / 20pt | `\setbeamerfont{frametitle}` |
| **标题页 — 标题** | `\title{}` 内容 | 20pt / 24pt | `\setbeamerfont{title}` |
| **标题页 — 副标题** | `\subtitle{}` 内容 | 14pt / 17pt | `\setbeamerfont{subtitle}` |
| **标题页 — 作者** | `\author{}` 内容 | 10pt / 13pt | `\setbeamerfont{author}` |
| **标题页 — 单位** | `\institute{}` 内容 | 8pt / 10pt | `\setbeamerfont{institute}` |
| **标题页 — 日期** | `\date{}` 内容 | 7pt / 9pt | `\setbeamerfont{date}` |
| **页眉 — 章节名** | 当前 `\section{}` 名称（最左） | 12pt / 14pt | `\setbeamerfont{section in head/foot}` |
| **目录 — 节条目** | `研究背景`、`项目定位` … | 12pt / 15pt | `\setbeamerfont{section in toc}` |
| **目录 — 子节条目** | 二级目录项 | 10pt / 13pt | `\setbeamerfont{subsection in toc}` |

### v1（经典版）字号

v1 使用 Beamer 默认相对字号，不单独设置绝对字号。所有文字大小由文档类 `\documentclass[11pt]` 决定：

| 显示位置 | 内容 | 11pt 基字下 |
|---|---|---|
| **帧标题** | 顶部渐变条左对齐 | ~11pt bold |
| **页眉章节导航** | 所有节名横排 | 7pt |
| **标题页 — 标题** | `\title{}` 内容 | ~20pt (`\huge`) |
| **正文** | block 内文字、itemize | ~11pt |

### 随文档类字号变化（v1 和 v2 共用）

| 显示位置 | 内容 | 9pt 基字下 | 11pt 基字下 | 控制命令 |
|---|---|---|---|---|
| **正文** | block 内文字、itemize、enumerate | ~9pt | ~11pt | `\documentclass[9pt/11pt]` |
| **block 标题** | `\begin{block}{标题}` | ~9pt bold | ~11pt bold | `\setbeamerfont{block title}` |
| **图表标题** | `\caption{}` | ~7pt | ~8pt | `\setbeamerfont{caption}`（`\scriptsize`） |
| **脚注 — 作者/日期/标题** | 底部主题色栏文字 | ~7pt | ~8pt | 继承 `\setbeamerfont{footline}` |
| **脚注 — 页码** | `1 / 12` | ~7pt | ~8pt | 同上 |

> **修改方法**：
> - **v2**：编辑 `seu_clean_green.sty` 或 `seu_clean_blue.sty`（位于项目根目录），找到 `%%% Font sizes` 段落（约第 110–130 行），修改对应的 `\setbeamerfont`。
> - **v1**：编辑 `seu_clean_v1.sty`，直接修改 `\setbeamerfont` 或按需添加绝对字号。

---

## 许可证

GPL-3.0 © Narcissus-xwy
