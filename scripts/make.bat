@echo off
title SEU-Beamer-Slide-Narcissus 编译工具
chcp 65001 >nul

REM 切换到项目根目录（脚本在 scripts/ 子目录）
cd /d "%~dp0.."

echo ========================================
echo   SEU-Beamer-Slide-Narcissus 编译工具
echo ========================================
echo.
echo 你可以直接拖拽 .tex 文件到本窗口，或手动输入文件名
echo.
set /p texfile="请输入 .tex 文件路径（不含扩展名，直接回车默认 example_clean）："

if "%texfile%"=="" set texfile=example_clean

REM 去除可能带有的 .tex 后缀
if /i "%texfile:~-4%"==".tex" set texfile=%texfile:~0,-4%

REM 去除可能带有的双引号（拖拽文件时会产生）
set texfile=%texfile:"=%

REM 如果在根目录找不到，自动在 examples/ 下查找
if not exist "%texfile%.tex" (
    if exist "examples\%texfile%.tex" (
        set texfile=examples\%texfile%
    ) else (
        echo.
        echo 错误：找不到文件 %texfile%.tex
        echo       也在 examples/ 目录下查找过，未找到。
        pause
        exit /b 1
    )
)

REM 确保 out 输出目录存在
if not exist out mkdir out

echo.
echo 正在编译：%texfile%.tex
echo 输出目录：out\
echo.

xelatex -output-directory=out "%texfile%" -interaction=nonstopmode
if %errorlevel% neq 0 (
    echo.
    echo [警告] 第一次编译有警告或错误，继续第二次...
)
xelatex -output-directory=out "%texfile%" -interaction=nonstopmode
if %errorlevel% neq 0 (
    echo.
    echo [警告] 第二次编译有警告或错误，请检查 out\%texfile%.log
)

echo.
echo 清理临时文件...
del out\*.aux /s /q >nul 2>&1
del out\*.bak /s /q >nul 2>&1
del out\*.bbl /s /q >nul 2>&1
del out\*.blg /s /q >nul 2>&1
del out\*.dvi /s /q >nul 2>&1
del out\*.fdb_latexmk /s /q >nul 2>&1
del out\*.lof /s /q >nul 2>&1
del out\*.lol /s /q >nul 2>&1
del out\*.lot /s /q >nul 2>&1
del out\*.nav /s /q >nul 2>&1
del out\*.out /s /q >nul 2>&1
del out\*.snm /s /q >nul 2>&1
del out\*.synctex.gz /s /q >nul 2>&1
del out\*.thm /s /q >nul 2>&1
del out\*.toc /s /q >nul 2>&1
del out\*.log /s /q >nul 2>&1

echo.
echo ========================================
echo   编译完成！
echo   PDF 文件：out\%texfile%.pdf
echo ========================================
echo.
pause
