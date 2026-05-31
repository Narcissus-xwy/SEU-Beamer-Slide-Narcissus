@echo off
title SEU-Beamer-Slide-Narcissus 编译工具
chcp 65001 >nul

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

echo.
echo 正在编译：%texfile%.tex
echo.

xelatex "%texfile%" -interaction=nonstopmode
if %errorlevel% neq 0 (
    echo.
    echo [警告] 第一次编译有警告或错误，继续第二次...
)
xelatex "%texfile%" -interaction=nonstopmode
if %errorlevel% neq 0 (
    echo.
    echo [警告] 第二次编译有警告或错误，请检查 %texfile%.log
)

echo.
echo 清理临时文件...
del *.aux /s /q >nul 2>&1
del *.bak /s /q >nul 2>&1
del *.log /s /q >nul 2>&1
del *.bbl /s /q >nul 2>&1
del *.dvi /s /q >nul 2>&1
del *.blg /s /q >nul 2>&1
del *.thm /s /q >nul 2>&1
del *.toc /s /q >nul 2>&1
del *.out /s /q >nul 2>&1
del *.lof /s /q >nul 2>&1
del *.lol /s /q >nul 2>&1
del *.lot /s /q >nul 2>&1
del *.nav /s /q >nul 2>&1
del *.snm /s /q >nul 2>&1
del *.fdb_latexmk /s /q >nul 2>&1
del *.synctex.gz /s /q >nul 2>&1

echo.
echo ========================================
echo   编译完成！请查看 %texfile%.pdf
echo ========================================
echo.
pause
