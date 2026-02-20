# Profile Likelihood Visualization
#
# This script computes and plots the profile likelihood for the location parameter mu
# of a Folded Normal distribution. It aims to visualize the "kink" at mu=0 and the
# strictly decreasing nature of the profile path.

source("code/folded_normal_functions.R")

# Generate a synthetic dataset
set.seed(123)
n <- 100
true_mu <- 0
true_sigma <- 1
y <- abs(rnorm(n, mean = true_mu, sd = true_sigma))

# Define a grid of mu values around the truth (0)
mu_grid <- seq(-0.5, 0.5, length.out = 100)
profile_lik <- numeric(length(mu_grid))
sigma_hat_path <- numeric(length(mu_grid))

# Compute profile likelihood
for (i in seq_along(mu_grid)) {
  mu_val <- mu_grid[i]
  
  # Maximize log-likelihood w.r.t sigma for fixed mu
  # We use optimize for 1D optimization
  # The log-likelihood function for fixed mu is:
  # ll(sigma) = -n*log(sigma) - (1/(2*sigma^2)) * sum(y^2 + mu^2) + sum(log(cosh(y*mu/sigma^2)))
  
  # Define the function to MAXIMIZE (negative of neg_loglik)
  # But neg_loglik_fold takes theta = c(mu, sigma)
  
  obj_fun <- function(sigma) {
    neg_loglik_fold(c(mu_val, sigma), y)
  }
  
  # Optimize over sigma > 0.
  # We know sigma is around 1, so search in [0.1, 5]
  res <- optimize(obj_fun, interval = c(0.1, 5))
  
  profile_lik[i] <- -res$objective # Store the log-likelihood value
  sigma_hat_path[i] <- res$minimum # Store the optimal sigma for this mu
}

# Plotting
png("profile_likelihood.png", width = 800, height = 600)
par(mfrow = c(1, 2))

# 1. Profile Likelihood
plot(mu_grid, profile_lik, type = "l", lwd = 2, col = "blue",
     main = "Profile Likelihood of Mu",
     xlab = expression(mu), ylab = "Log-Likelihood")
abline(v = 0, lty = 2, col = "gray")
# Highlight the maximum
max_idx <- which.max(profile_lik)
points(mu_grid[max_idx], profile_lik[max_idx], pch = 19, col = "red")

# 2. Profile Path of Sigma
plot(mu_grid, sigma_hat_path, type = "l", lwd = 2, col = "darkgreen",
     main = "Profile Path: Sigma vs Mu",
     xlab = expression(mu), ylab = expression(hat(sigma)(mu)))
abline(v = 0, lty = 2, col = "gray")

dev.off()
cat("Plot saved to profile_likelihood.png\n")
