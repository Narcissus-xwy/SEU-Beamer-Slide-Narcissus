@echo off
chcp 65001 >nul
title SEU-Beamer-Slide-Narcissus 安装脚本

REM 切换到项目根目录（脚本在 scripts/ 子目录）
cd /d "%~dp0.."

echo ========================================
echo   SEU-Beamer-Slide-Narcissus 安装脚本
echo   Windows
echo ========================================
echo.

REM ─── 1. 检查 xelatex ────────────────────────────────────
echo [1/2] 检查 LaTeX 编译器 ...
where xelatex >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('where xelatex') do set XELATEX_PATH=%%i
    echo [✔] xelatex 已找到：%XELATEX_PATH%
) else (
    echo [!] 未找到 xelatex
    echo.
    echo     请安装 TeX Live 或 MiKTeX：
    echo     - TeX Live: https://tug.org/texlive/
    echo     - MiKTeX:   https://miktex.org/
    echo.
    echo     安装后确保 xelatex 在系统 PATH 中。
    echo.
    pause
)

echo.

REM ─── 2. 安装 Python 依赖 ─────────────────────────────────
echo [2/2] 安装 Python 依赖 ...
set REQUIREMENTS=%~dp0requirements.txt
if exist "%REQUIREMENTS%" (
    pip install -r "%REQUIREMENTS%"
    if %errorlevel% equ 0 (
        echo [✔] Python 依赖安装完成
    ) else (
        echo [!] pip install 失败，请手动执行：
        echo     pip install -r scripts\requirements.txt
    )
) else (
    echo [!] requirements.txt 不存在
)

echo.
echo ========================================
echo   安装完成！
echo.
echo   使用方法：
echo     双击 scripts\make.bat    编译 example_clean
echo     拖拽 .tex 到 make.bat   编译自定义文件
echo.
echo   PDF → PPTX 转换：
echo     双击 scripts\pdf2ppt.bat
echo ========================================
pause
