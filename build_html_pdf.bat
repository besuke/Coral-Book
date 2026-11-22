@echo off
rem Builds the HTML book (_book\) and the PDF (_pdf_build\coral-book.pdf) in one go.
rem Unlike build_all_outputs.bat it does NOT clean up, commit or push: check the result, then commit by hand.
rem Usage: double-click, or run build_html_pdf.bat from any folder. A log of each step goes to build_logs\.

setlocal
cd /d "%~dp0"

if not exist build_logs mkdir build_logs
set STAMP=%DATE:/=-%_%TIME: =0%
set STAMP=%STAMP::=-%
set STAMP=%STAMP:~0,19%

echo.
echo === 1/2 HTML (quarto render --to html) ===
quarto render --to html > "build_logs\html_%STAMP%.log" 2>&1
if errorlevel 1 (
    echo HTML build FAILED. See build_logs\html_%STAMP%.log
    pause
    exit /b 1
)
findstr /c:"WARN" "build_logs\html_%STAMP%.log" >nul && echo WARNING: the HTML log contains WARN, see build_logs\html_%STAMP%.log

echo.
echo === 2/2 PDF (quarto render --profile pdf --to pdf) ===
quarto render --profile pdf --to pdf > "build_logs\pdf_%STAMP%.log" 2>&1
if errorlevel 1 (
    echo PDF build FAILED. See build_logs\pdf_%STAMP%.log
    pause
    exit /b 1
)

echo.
if not exist "_book\index.html" (
    echo Expected output not found: _book\index.html
    pause
    exit /b 1
)
if not exist "_pdf_build\coral-book.pdf" (
    echo Expected output not found: _pdf_build\coral-book.pdf
    pause
    exit /b 1
)
echo OK: _book\index.html
echo OK: _pdf_build\coral-book.pdf
echo.
echo === HTML AND PDF COMPLETE (nothing was committed) ===
pause
endlocal
