## Lib block
library(rmarkdown)

## Main block
# Run app on fixed port
run('expoFitter.rmd', 
    shiny_args = list(port = 9191))