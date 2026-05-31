@echo off
title SEU-Beamer-Slide-Narcissus PDF -> PPTX
chcp 65001 >nul

echo ========================================
echo   SEU-Beamer-Slide-Narcissus
echo   PDF -> PPTX (300 DPI)
echo ========================================
echo.
echo ^<拖拽 .pdf 文件到本窗口，或手动输入路径^>
echo.
set /p pdffile="请输入 .pdf 文件路径（直接回车退出）："

if "%pdffile%"=="" goto :eof
set pdffile=%pdffile:"=%
echo.
set /p dpi="渲染 DPI（默认 300，论文级质量）："
if "%dpi%"=="" set dpi=300
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