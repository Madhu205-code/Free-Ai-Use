@echo off
REM Serve this folder over http://localhost:8000
REM Windows: double-click this file.
cd /d "%~dp0"
set PORT=8000

echo.
echo   +----------------------------------------------+
echo   ^|  AI Console -- local server                  ^|
echo   ^|                                              ^|
echo   ^|  Open: http://localhost:%PORT%/ai-console.html ^|
echo   ^|                                              ^|
echo   ^|  Press Ctrl+C in this window to stop.        ^|
echo   +----------------------------------------------+
echo.

REM Open the browser after a short delay
start "" /b cmd /c "timeout /t 2 /nobreak >nul & start http://localhost:%PORT%/ai-console.html"

REM Try python, then python3, then npx
where python >nul 2>nul
if %errorlevel% == 0 (
  python -m http.server %PORT%
  goto :end
)
where py >nul 2>nul
if %errorlevel% == 0 (
  py -m http.server %PORT%
  goto :end
)
where npx >nul 2>nul
if %errorlevel% == 0 (
  npx --yes serve . -l %PORT%
  goto :end
)

echo.
echo Need Python or Node.js installed. Get Python from https://python.org
echo.
pause
:end
