### Sys block
# Suppress warnings
options(warn = -1)

### Main block
# 2D, nested list mimicking dict dstructure
dependencies <- list(remotes = c(package = 'remotes', version = NA),
                     dplyr = c(package = 'dplyr', version = '1.1.4'),
                     minpack = c(package = 'minpack.lm', version = '1.2.4'),
                     DT = c(package = 'DT', version = '0.33'),
                     shiny = c(package = 'shiny', version = '1.9.1'))

# Dependency check/installation
for (i in dependencies) {
  ## Control loop to check for presence/absence of dependency
  if (i[['package']] %in% rownames(installed.packages()) == TRUE) {
    # Acquire package version
    installedVersion <- packageVersion(i[['package']])
    
    # Correctly compare version by converting packageVersion object to character
    if (is.na(i[['version']]) || as.character(installedVersion) == i[['version']]) {
      # If dependency is installed with correct version, return indicator
      cat('Requirement already satisfied:', i[['package']], '-', i[['version']], '\n\n')
      
    } else {
      # If version mismatch, install required version
      cat('Updating', i[['package']], 'to version', i[['version']], '\n\n')
      remotes::install_version(i[['package']], 
                               version = i[['version']], 
                               repos = 'http://cran.rstudio.com/')
      cat('\n')
    }

  } else {
    if (i[['package']] != 'remotes') {
      # If dependency not satisfied and not 'remotes', install
      cat('Installing', i[['package']], 'version', i[['version']], '\n\n')
      remotes::install_version(i[['package']], 
                               version = i[['version']], 
                               repos = 'http://cran.rstudio.com/')
      cat('\n')
      
    } else {
      # If dependency not satisfied and is 'remotes', install
      cat('Installing remotes package \n\n')
      suppressWarnings(install.packages(i[['package']], repos = 'http://cran.rstudio.com/'))
      cat('\n')
    }
  }
}
