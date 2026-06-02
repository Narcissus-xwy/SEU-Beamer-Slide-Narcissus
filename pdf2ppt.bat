@echo off
title SEUPPT-Narcissus PDF 转 PPTX
chcp 65001 >nul

echo ========================================
echo   SEUPPT-Narcissus
echo   PDF 转 PPTX (1200 DPI)
echo ========================================
echo.
echo 拖拽 .pdf 文件到本窗口，或手动输入路径
echo PDF 默认在 out\ 目录下
echo.
set /p pdffile="请输入 .pdf 文件路径（直接回车退出）："

if "%pdffile%"=="" goto :eof
set pdffile=%pdffile:"=%
echo.
set dpi=1200
set /p input_dpi="渲染 DPI（默认 1200）："
if not "%input_dpi%"=="" set dpi=%input_dpi%
echo.
echo 正在转换：%pdffile%
echo DPI：%dpi%
echo.
python "%~dp0pdf2ppt.py" "%pdffile%" --dpi %dpi%

if %errorlevel% neq 0 (
    echo.
    echo [错误] 转换失败
) else (
    echo.
    echo ========================================
    echo   转换完成！
    echo ========================================
)
echo.
pause
