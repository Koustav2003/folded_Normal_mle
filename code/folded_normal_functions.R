#' Folded Normal Distribution Functions
#'
#' This script implements the PDF, Log-Likelihood, and MLE for the Folded Normal distribution.
#'
#' @author Koustav Mallik (M.Stat 2nd year student, ISI Kolkata )

#' Probability Density Function of the Folded Normal Distribution
#'
#' @param x Vector of non-negative quantiles.
#' @param mu Location parameter (mean of the underlying normal distribution).
#' @param sigma Scale parameter (standard deviation of the underlying normal distribution).
#' @return Vector of densities.
dnorm_fold <- function(x, mu, sigma) {
  if (any(x < 0)) stop("x must be non-negative for Folded Normal distribution.")
  if (sigma <= 0) stop("sigma must be positive.")
  
  term1 <- dnorm(x, mean = mu, sd = sigma)
  term2 <- dnorm(x, mean = -mu, sd = sigma)
  
  return(term1 + term2)
}

#' Log-Likelihood Function
#'
#' @param theta Vector of parameters c(mu, sigma).
#' @param x Vector of data.
#' @return Negative log-likelihood (for minimization).
neg_loglik_fold <- function(theta, x) {
  mu <- theta[1]
  sigma <- theta[2]
  
  if (sigma <= 0) return(Inf)
  
  # Calculate log-likelihood
  ll <- sum(log(dnorm_fold(x, mu, sigma)))
  
  return(-ll) # Return negative for minimization
}

#' Maximum Likelihood Estimation
#'
#' @param x Vector of data.
#' @param start_vals Initial values for c(mu, sigma). Defaults to method of moments approximation.
#' @return List containing estimated parameters and convergence info.
mle_fold <- function(x, start_vals = NULL) {
  if (is.null(start_vals)) {
    # Simple initialization: 
    # E[X^2] = mu^2 + sigma^2
    # E[X] is complicated, but approx mu if mu >> sigma, or sigma*sqrt(2/pi) if mu=0.
    # Let's start with mu = mean(x) and sigma = sd(x) as a rough guess.
    start_vals <- c(mean(x), sd(x))
  }
  
  # Optimization using optim
  # We use "L-BFGS-B" to enforce sigma > 0
  fit <- optim(
    par = start_vals,
    fn = neg_loglik_fold,
    x = x,
    method = "L-BFGS-B",
    lower = c(-Inf, 1e-6),
    upper = c(Inf, Inf),
    hessian = TRUE
  )
  
  return(fit)
}
