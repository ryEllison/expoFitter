### Lib block
library(rsconnect)

### Main block
## Control loop to check for active instance of rsconnect
if (Sys.getenv('R_CONFIG_ACTIVE') == 'rsconnect') {
  # If rsconnect active, deploy app
  deployDoc('..\\app\\deploy\\expoFitter.rmd')
  
} else {
  # If reconnect is not active, register account info
  setAccountInfo(name = ,
                 token = ,
                 secret = )
  
  # Deploy app
  deployDoc('..\\app\\deploy\\expoFitter.rmd')
}