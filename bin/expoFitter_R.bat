:: System batch file to automate launching of app locally

:: Echo off to ensure verbosity in terminal is deactivated
@echo off

:: Title of terminal process
TITLE Launch expoFitter

:: Echo to terminal
echo [31m~! Hosting app using machine as local server !~[0m

:: Start R interpreter in background to deploy app to fixed port
echo:
start /B Rscript "..\scripts\launch.R"

:: Launch app via default browser on local, fixed port
start http://127.0.0.1:3838

:: Echo to terminal
echo [34m** Reminder: Close terminal upon shutting down web app **[0m
echo: