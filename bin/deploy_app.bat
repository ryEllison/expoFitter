:: System batch file to automate deployment process to shinyapp.io

:: Echo off to ensure verbosity in terminal is deactivated
@echo off

:: Title of terminal process
TITLE Deploy app to shinyapp.io

:: Echo to terminal
echo [31m~! Executing deployment script !~[0m

:: Call R interpreter and .R file
echo:
Rscript "..\scripts\deploy.R"

:: System pause before closure of terminal
echo:
pause