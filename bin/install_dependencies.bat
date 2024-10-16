:: System batch file to automate dependency installation

:: Echo off to ensure verbosity in terminal is deactivated
@echo off

:: Title of terminal process
TITLE Install app dependencies

:: Echo to terminal
echo [31m~! Checking/installing requisite dependendencies !~[0m

:: Call R interpreter and .R file
echo:
Rscript "..\scripts\install.R"

:: System pause before closure of terminal
pause