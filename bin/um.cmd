@echo off
rem universal-modder CLI launcher for Windows (cmd / PowerShell).
rem Mirrors bin/um: uses uv when available, otherwise the system Python.
setlocal
for %%I in ("%~dp0..") do set "ROOT=%%~fI"
if defined UM_NO_UV goto system
where uv >nul 2>nul
if errorlevel 1 goto system
uv run --quiet --project "%ROOT%" python -m um %*
exit /b %errorlevel%

:system
if defined PYTHONPATH (set "PYTHONPATH=%ROOT%;%PYTHONPATH%") else (set "PYTHONPATH=%ROOT%")
where python >nul 2>nul
if errorlevel 1 goto py_launcher
python -m um %*
exit /b %errorlevel%

:py_launcher
py -3 -m um %*
exit /b %errorlevel%
