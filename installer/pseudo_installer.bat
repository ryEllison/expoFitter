:: System batch file to automate pseudo-installation of expoFitter

:: Echo off to ensure verbosity in terminal is deactivated
@echo off

:: Title of terminal process
TITLE Pseudo-install expoFitter

:: Navigate to the directory where the script is located
cd /d %~dp0

:: Echo to terminal to indicate the start of admin check
echo [31m~! Checking for admin permissions !~[0m

:: Check for administrative permissions
NET SESSION >nul 2>&1

:: If error level is non-zero (meaning no admin permissions)
if %errorlevel% neq 0 (
    echo:
    echo Admin? 0
    echo Requesting admin privileges...

    :: Add a timeout before batch script restarts with elevated rights
    timeout 5 /nobreak

    :: Re-run with administrator privileges using PowerShell
    powershell -Command "Start-Process '%~f0' -Verb RunAs"

    :: Exit current non-admin script
    exit

) else (
    :: If error level is zero (meaning admin permissions already granted)
    echo:
    echo Admin? 1
)

:: Echo to terminal to indicate folder creation
echo:
echo [31m~! Creating 'expoFitter' root in Program Files !~[0m

:: Create root folder for expoFitter in Program Files
echo:
mkdir "C:\Program Files\expoFitter"

:: Echo to terminal to indicate start of copying files
echo:
echo [31m~! Installing to root !~[0m

:: Copy the "expoFitter-win32-ia23" folder to the root
echo:
xcopy ".\expoFitter-win32-ia32" "C:\Program Files\expoFitter\expoFitter-win32-ia23" /s /h /i

:: Copy the "expoFitter_electron" shortcut to the root
echo:
xcopy "expoFitter_electron.lnk" "C:\Program Files\expoFitter\"

:: Explanation of flags:
:: /s - Copies directories and subdirectories except empty ones
:: /e - Copies all subdirectories, including empty ones
:: /h - Copies hidden and system files
:: /i - Assumes the destination is a directory (useful if it doesn't exist yet)
:: /y - Suppresses confirmation to overwrite existing files

::Echo to terminal
echo:
echo [31m~! Creating expoFitter shortcut on Desktop !~[0m

:: Copy the "expoFitter_electron" shortcut to Desktop
echo:
xcopy "expoFitter_electron.lnk"  "%UserProfile%\Desktop\expoFitter.lnk"

:: Echo to terminal to indicate the process is finished
echo:
echo [34m~! Installation complete !~[0m

:: Pause to keep terminal open for user review
echo:
pause
