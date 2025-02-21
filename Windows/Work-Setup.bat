@ECHO OFF

REM Prevent output from keeping terminal open.
start "" /B slack >nul 2>&1

SET ThisScriptsDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptsDirectory%Work-Setup.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%PowerShellScriptPath%'";

:: Un-comment to keep window open for debugging.
REM @PAUSE
