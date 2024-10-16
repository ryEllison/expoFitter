:: System batch file to automate construction of README docs

:: Echo off to ensure verbosity in terminal is deactivated
@echo off

:: Title of terminal process
TITLE Construct README

:: Echo to terminal
echo [31m~! Building README from .rmd source !~[0m

:: Move rmd source to top of heap
echo:
move "..\rmd\README.rmd" "..\"

:: Call R interpreter and render .rmd file
Rscript -e "rmarkdown::render('..\\README.rmd', quiet = TRUE)"

:: System pause before moving docs
timeout 5 /nobreak

:: Move rmd source to appropriate directory
echo:
move "..\README.rmd" "..\rmd"

:: System pause before closure of terminal
echo:
pause