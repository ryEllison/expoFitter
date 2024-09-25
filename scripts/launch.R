## Lib block
library(rmarkdown)

## Main block
# Run app on fixed port
run('..\\app\\expoFitter.rmd', 
    shiny_args = list(port = 3838))