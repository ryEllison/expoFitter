# Utilize/Helper Functions ------------------------------------------------

#' #' Load necessary packages for application.
#' #' @return Loads packages into environment silently.
#' loadDependencies <- function(){
#'   # Suppress warnings
#'   options(warn = -1)
#'   
#'   # Atomic char vector of required packages
#'   dependencies <- c('dplyr', 
#'                     'minpack.lm', 
#'                     'DT',
#'                     'shiny')
#'   
#'   # Load packages iteratively
#'   for (pkg in dependencies) {
#'     # Quiet ingestion
#'     suppressMessages(library(pkg, character.only = TRUE))
#'   }
#' }

#' Create a dynamic slider input for UI.
#' @param inputId ID for slider input.
#' @param label Label for slider.
#' @param minVal Minimum value for slider.
#' @param maxVal Maximum value for slider.
#' @param stepVal Step value for slider.
#' @param defaultVal Default value for slider.
#' @param dataVal Optional data-driven value for slider.
#' @return A sliderInput UI element.
createSlider <- function(inputId, 
                         label, 
                         minVal, 
                         maxVal, 
                         stepVal, 
                         defaultVal, 
                         dataVal = NULL){
  
  # Create slider with default or data-driven value
  sliderInput(inputId = inputId, 
              label = label, 
              min = minVal, 
              max = maxVal, 
              step = stepVal, 
              value = ifelse(is.null(dataVal), defaultVal, dataVal))
}

#' Calculate coefficient of determination (R^2).
#' @param estimated Vector of estimated values.
#' @param actual Vector of actual values.
#' @return R^2 - Coefficient of determination as a numeric value.
rSq <- function(estimated, actual){
  # Compute and return R^2
  return(cor(estimated, actual)^2)
}

#' Calculate the first-order derivative using finite differences.
#' @param x Vector of x values.
#' @param y Vector of y values.
#' @return Vector of derivative approximations.
finiteDifferences <- function(x, y){
  # Ensure length of x and y vectors are equal
  if (length(x) != length(y)){
    # Throw error if lengths are unequal
    stop('x and y vectors must have equal length')
  }
  
  # Determine length of vectors
  n <- length(x)
  
  # Initialize vector for storing derivative approximations
  fdx <- vector(length = n)
  
  # Calculate the finite differences using forward differencing
  for (i in 2:n){
    # Forward differencing for the first n-1 elements
    fdx[i - 1] <- (y[i - 1] - y[i]) / (x[i - 1] - x[i])
  }
  
  # Use backward differencing for the last element
  fdx[n] <- (y[n] - y[n - 1]) / (x[n - 1] - x[n])
  
  # Return vector of finite differences
  return(fdx)
}

#' Calculate simple differences (differentiation) of a vector.
#' @param y Vector of y values.
#' @return Vector of simple differences.
differences <- function(y){
  # Determine length of vectors
  n <- length(y)
  
  # Initialize vector for storing simple differences
  fdy <- vector(length = n)
  
  # Calculate simple differences using forward differencing
  for (i in 2:n){
    # Forward differencing for the first n-1 elements
    fdy[i - 1] <- (y[i - 1] - y[i])
  }
  
  # Use backward differencing for the last element
  fdy[n] <- (y[n] - y[n - 1])
  
  # Return the vector of simple differences
  return(fdy)
}

#' Apply derivative filtering and simple difference filtering to the data.
#' @param expData Dataframe with time (t) and current (i) columns.
#' @param dxFilter Boolean to apply derivative filtering.
#' @return Filtered dataframe.
applyFiltering <- function(expData){
  # Approximate first derivative of current using finite differences
  expData$dx <- finiteDifferences(expData[[1]], expData[[2]])
  
  # Filter data based on standard deviation of the derivative
  expData <- filter(expData, between(dx, -sd(dx), sd(dx)))
  
  # Calculate simple differences in filtered current data
  expData$delta <- differences(expData[[2]])
  
  # Filter data further based on standard deviation of the simple differences
  expData <- filter(expData, between(delta, -sd(delta), sd(delta)))
  
  # Return filtered dataframe
  return(expData)
}

# Core Computational Functions --------------------------------------------

#' Plot initial data for visualization.
#' @param data Dataset to be plotted.
#' @param yLimit Y-axis limit for the plot.
plotFigure <- function(data, yLimit){
  # Plot current vs. time
  plot(data[[2]] ~ data[[1]], 
       col = 'black', 
       frame.plot = FALSE, 
       type = 'l', 
       ylim = c(0, yLimit), 
       ylab = 'Current (nA)', 
       xlab = 'Time (s)')
  
  # Add x-axis
  axis(side = 1)
  
  # Add legend
  legend('topright', 
         inset = .02, 
         legend = c(expression(paste(I[KCa], ' + ', I[Kd], ' + ', I[pas])), 
                    'Single-Exponential Model', 
                    'Double-Exponential Model'), 
         col = c('black', 
                 'white', 
                 'white'), 
         text.col = c('black', 
                      'white', 
                      'white'), 
         lty = 1, 
         cex = 1, 
         bty = 'n')
}

#' Fit a non-linear model based on the specified model type.
#' @param expData Dataset to be fitted.
#' @param initParams List of initial parameters for the model.
#' @param modelType Type of model to fit (Single-Exponential, Double-Exponential).
#' @return Fitted model coefficients.
fitModel <- function(expData, 
                     initParams, 
                     modelType){
  
  # Switch case statement to determine formula based on the model type
  formula <- switch(modelType,
                    'Single-Exponential' = i ~ a * exp(-t / b) + c,
                    'Double-Exponential' = i ~ a * exp(-t / b) + c * exp(-t / d) + e)
  
  # Fit the model
  model <- nlsLM(formula, 
                 data = expData, 
                 start = initParams, 
                 control = nls.lm.control(maxiter = 500, maxfev = 1000))
  
  # Nest list object with model and coefficients
  return(list(model = model, 
              coefs = coef(model)))
}

#' Wrangle data, fit non-linear models, and visualize results.
#' @param data Dataset to be preprocessed and fitted.
#' @param a_ Initial condition for parameter A.
#' @param b_ Initial condition for parameter B.
#' @param c_ Initial condition for parameter C.
#' @param d_ Initial condition for parameter D.
#' @param e_ Initial condition for parameter E.
#' @param doubleBoth Specifies which model to use (Single-Exponential, Double-Exponential, or Both).
#' @param dxFilter Boolean to apply derivative filtering to data.
#' @param visualize Boolean to determine if results should be visualized.
wrangleFitVisualize <- function(data, 
                                a_, 
                                b_, 
                                c_, 
                                d_, 
                                e_, 
                                doubleBoth,
                                visualize = TRUE){
  
  # Max amplitude of current
  iAmplitude <- max(data[[2]])
  
  # Identify portion of current trace for exponential fitting
  lowerBound <- which.max(data[[2]])
  upperBound <- length(data[[2]]) - (1 / 0.001)
  
  # Wrangle data into a format suitable for model fitting
  expData <- data.frame(t = c(data[[1]][lowerBound:upperBound]), 
                        i = c(data[[2]][lowerBound:upperBound]))
  
  # Filter data to keep values between 25 and the max amplitude
  expData <- filter(expData, between(i, 25, iAmplitude))
  
  # Apply double differential filtering
  expData <- applyFiltering(expData)
  
  ## Initial parameters for the models
  # Single-exponential conditions
  nlInitConditions <- list(a = a_, 
                           b = b_, 
                           c = c_)
  
  # Double-exponential conditions
  dnlInitConditions <- list(a = a_, 
                            b = b_, 
                            c = c_, 
                            d = d_, 
                            e = e_)
  
  # Fit models based on specified type
  # Single-exponential model
  nlMod <- fitModel(expData, 
                    nlInitConditions, 
                    'Single-Exponential')
  
  # Double-exponential model
  dnlMod <- if (doubleBoth != 'Single-Exponential'){
    fitModel(expData, 
             dnlInitConditions, 
             'Double-Exponential')
  
  } else {
    NULL
  }
  
  # Visualization or output logic
  if (visualize){
    # Visualize model
    plotModel(nlMod$coefs, 
              dnlMod$coefs, 
              doubleBoth)
    
  } else {
    # Output model summary
    outputModelSummary(nlMod$model, 
                       dnlMod$model, 
                       expData, 
                       doubleBoth)
  }
}

#' Plot the fitted models based on the specified model type.
#' @param nlTheta Coefficients of the single-exponential model.
#' @param dnlTheta Coefficients of the double-exponential model (optional).
#' @param modelType Type of model plotted (Single-Exponential, Double-Exponential, or Both).
plotModel <- function(nlTheta, 
                      dnlTheta = NULL, 
                      modelType){
  
  if (modelType == 'Both'){
    # Determine legend position for plot
    position <- legend('topright', 
                       inset = .02, 
                       legend = c(expression(paste(I[KCa], ' + ', I[Kd], ' + ', I[pas])), 
                                  'Single-Exponential Model', 
                                  'Double-Exponential Model'), 
                       col = c('black', 
                               'red', 
                               'blue'), 
                       lty = 1, 
                       cex = 1, 
                       bty = 'n', 
                       plot = FALSE)
    
    # Overlay blank rectangle to cover first legend
    rect(position$rect$left, 
         position$rect$top, 
         position$rect$left + position$rect$w, 
         position$rect$top - position$rect$h, 
         col = 'white', 
         border = 'white')
    
    # Redraw legend with correct labels and colors
    legend('topright', 
           inset = .02, 
           legend = c(expression(paste(I[KCa], ' + ', I[Kd], ' + ', I[pas])), 
                      'Single-Exponential Model', 
                      'Double-Exponential Model'), 
           col = c('black', 
                   'red', 
                   'blue'), 
           lty = 1, 
           cex = 1, 
           bty = 'n')
    
    # Overlay single exponential fit curve
    curve(nlTheta['a'] * exp(-x / nlTheta['b']) + nlTheta['c'], 
          lty = 'dashed', 
          lwd = 2, 
          col = 'red', 
          add = TRUE)
    
    # Overlay double exponential fit curve
    curve(dnlTheta['a'] * exp(-x / dnlTheta['b']) + dnlTheta['c'] * exp(-x / dnlTheta['d']) + dnlTheta['e'], 
          lty = 'dashed', 
          lwd = 2, 
          col = 'blue', 
          add = TRUE)
    
  } else if (modelType == 'Double-Exponential'){
    # Determine legend position for double-exponential model plot
    position <- legend('topright', 
                       inset = .02, 
                       legend = c(expression(paste(I[KCa], ' + ', I[Kd], ' + ', I[pas])), 
                                  'Double-Exponential Model'), 
                       col = c('black', 
                               'blue'), 
                       lty = 1, 
                       cex = 1, 
                       bty = 'n', 
                       plot = FALSE)
    
    # Overlay blank rectangle to cover first legend
    rect(position$rect$left, 
         position$rect$top, 
         position$rect$left + position$rect$w, 
         position$rect$top - position$rect$h, 
         col = 'white', 
         border = 'white')
    
    # Redraw legend with correct labels and colors
    legend('topright', 
           inset = .02, 
           legend = c(expression(paste(I[KCa], ' + ', I[Kd], ' + ', I[pas])), 
                      'Double-Exponential Model'), 
           col = c('black', 
                   'blue'), 
           lty = 1, 
           cex = 1, 
           bty = 'n')
    
    # Overlay double exponential fit curve
    curve(dnlTheta['a'] * exp(-x / dnlTheta['b']) + dnlTheta['c'] * exp(-x / dnlTheta['d']) + dnlTheta['e'], 
          lty = 'dashed', 
          lwd = 2, 
          col = 'blue', 
          add = TRUE)
    
  } else {
    # Determine legend position for single-exponential model plot
    position <- legend('topright', 
                       inset = .02, 
                       legend = c(expression(paste(I[KCa], ' + ', I[Kd], ' + ', I[pas])), 
                                  'Single-Exponential Model'), 
                       col = c('black', 
                               'red'), 
                       lty = 1, 
                       cex = 1, 
                       bty = 'n', 
                       plot = FALSE)
    
    # Overlay blank rectangle to cover first legend
    rect(position$rect$left, 
         position$rect$top, 
         position$rect$left + position$rect$w, 
         position$rect$top - position$rect$h, 
         col = 'white', 
         border = 'white')
    
    # Redraw legend with correct labels and colors
    legend('topright', 
           inset = .02, 
           legend = c(expression(paste(I[KCa], ' + ', I[Kd], ' + ', I[pas])), 
                      'Single-Exponential Model'), 
           col = c('black', 
                   'red'), 
           lty = 1, 
           cex = 1, 
           bty = 'n')
    
    # Overlay single exponential fit curve
    curve(nlTheta['a'] * exp(-x / nlTheta['b']) + nlTheta['c'], 
          lty = 'dashed', 
          lwd = 2, 
          col = 'red', 
          add = TRUE)
  }
}

#' Output the summary of the fitted models based on the specified model type.
#' @param nlMod Fitted single-exponential model object.
#' @param dnlMod Fitted double-exponential model object (optional).
#' @param expData Dataset used for fitting.
#' @param modelType Type of model fitted (Single-Exponential, Double-Exponential, or Both).
outputModelSummary <- function(nlMod, 
                               dnlMod = NULL,
                               expData,
                               modelType){
  
  if (modelType == 'Both' || modelType == 'Single-Exponential'){
    ## Single-exponential model
    # Capture model formula
    eqn <- summary(nlMod)$formula
    
    # Exttract model coefficients
    nlTheta <- coef(nlMod)
    
    # Calculate model predictions
    nlmFit <- nlTheta['a'] * exp(-expData[[1]] / nlTheta['b']) + nlTheta['c']
    
    # Calculate R-squared
    rsq <- rSq(estimated = nlmFit, 
               actual = expData[[2]])
    
    # Get residual standard error
    rse <- paste(summary(nlMod)$sigma, 'nA')
    
    # Store outputs in list
    nlOutput <- list(eqn, 
                     nlTheta, 
                     rsq, 
                     rse)
    
    names(nlOutput) <- c('Variable Relationship', 
                         'Solution Parameters', 
                         'R^2', 
                         'RSE')
    
    # Print model results
    cat('Single-Exponential Fit: \n\n')
    print(nlOutput)
  }
  
  if (modelType == 'Both' || modelType == 'Double-Exponential'){
    ## Double-exponential model
    # Capture model formula
    eqn <- summary(dnlMod)$formula
    
    # Extract model coefficients
    dnlTheta <- coef(dnlMod)
    
    # Calculate model predictions
    dnlmFit <- dnlTheta['a'] * exp(-expData[[1]] / dnlTheta['b']) + dnlTheta['c'] * exp(-expData[[1]] / dnlTheta['d']) + dnlTheta['e']
    
    # Calculate R-squared
    rsq <- rSq(estimated = dnlmFit, 
               actual = expData[[2]])
    
    # Get residual standard error
    rse <- paste(summary(dnlMod)$sigma, 'nA')
    
    # Store outputs in list
    dnlOutput <- list(eqn, 
                      dnlTheta, 
                      rsq, 
                      rse)
    
    names(dnlOutput) <- c('Variable Relationship', 
                          'Solution Parameters', 
                          'R^2', 
                          'RSE')
    
    # Print model results
    cat('Double-Exponential Fit: \n\n')
    print(dnlOutput)
  }
}
