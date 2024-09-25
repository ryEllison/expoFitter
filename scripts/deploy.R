### Lib block
library(rsconnect)

### Main block
## Control loop to check for active instance of rsconnect
if (Sys.getenv('R_CONFIG_ACTIVE') == 'rsconnect') {
  # If rsconnect active, deploy app
  deployDoc('..\\app\\deploy\\expoFitter.rmd')
  
} else {
  # If reconnect is not active, register account info
  setAccountInfo(name = 'ryellison',
                 token = '61C48D86B889667AE3E615C9E8A7A033',
                 secret = 'CSD5+yBu07+xVXpqtTW7fMceH9zMnxwhGZQ8Qfuu')
  
  # Deploy app
  deployDoc('..\\app\\deploy\\expoFitter.rmd')
}