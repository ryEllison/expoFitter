:: System batch file to automate construction of README docs

:: Echo off to ensure verbosity in terminal is deactivated
@echo off

:: Title of terminal process
TITLE Construct README

:: Echo to terminal
echo [31m~! Building README from .rmd source !~[0m

:: Call R interpreter and render .rmd file
echo:
Rscript -e "rmarkdown::render('../rmd/README.rmd', quiet = TRUE)"

:: System pause before moving docs
timeout 5 /nobreak

:: Move docs to top of repo heap
echo:
move ../rmd/README.html ../
move ../rmd/README.md ../

:: System pause before closure of terminal
echo:
pause