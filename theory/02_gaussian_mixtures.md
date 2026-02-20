# Finite Gaussian Mixtures Theory

This document details the theoretical framework for Finite Gaussian Mixtures, focusing on Identifiability and the Hausdorff consistency of the Maximum Likelihood Estimator (MLE).

## 1. Model Definition

A Finite Gaussian Mixture Model (GMM) with $K$ components is defined by the probability density function (PDF):

$$
f(y; \boldsymbol{\theta}) = \sum_{k=1}^K w_k \cdot \phi(y; \mu_k, \sigma_k)
$$

where:
*   $w_k > 0$ are the mixing weights, satisfying $\sum_{k=1}^K w_k = 1$.
*   $\phi(y; \mu_k, \sigma_k)$ is the Gaussian PDF with mean $\mu_k$ and standard deviation $\sigma_k$.
*   $\boldsymbol{\theta} = \{ (w_k, \mu_k, \sigma_k) \}_{k=1}^K$ represents the set of parameters.

## 2. Identifiability

For a Gaussian Mixture Model to be well-posed, the parameters must be identifiable. This means that if two mixtures yield the same probability distribution, they must have the same parameters (up to label permutation).

### Fourier and Vandermonde Methods

The paper establishes identifiability using Fourier transform properties and Vandermonde matrices.

*   **Fourier Transform**: The characteristic function of a mixture is the weighted sum of the characteristic functions of the components:
    $$
    \psi_Y(t) = \sum_{k=1}^K w_k e^{i \mu_k t - \frac{1}{2}\sigma_k^2 t^2}
    $$
    This linear combination allows us to distinguish components based on their distinct $(\mu_k, \sigma_k)$ values.

*   **Vandermonde Matrices**: By examining the derivatives or moments of the characteristic function, we can form a system of equations that relates the observed moments to the unknown parameters. The distinctness of the component parameters ensures the determinant of the associated Vandermonde matrix is non-zero, guaranteeing a unique solution for the weights $w_k$ given the component parameters.

Specifically, the paper provides a short proof that:
> *Given distinct components $(\mu_k, \sigma_k)$ and positive weights $w_k$, the mixture distribution uniquely determines the parameters up to a permutation of the component labels.*

## 3. Hausdorff Consistency

### Definition

Standard consistency (convergence in parameter space) is complicated by the "label switching" problem in mixture models (e.g., swapping component 1 and component 2 yields the same distribution).

**Hausdorff Consistency** addresses this by considering the set of parameters as a whole, rather than individual vector components. The estimator $\hat{\boldsymbol{\theta}}_n$ is said to be Hausdorff consistent if the Hausdorff distance between the set of estimated parameters and the true parameter set converges to zero in probability.

$$
d_H(A, B) = \max \left( \sup_{a \in A} \inf_{b \in B} d(a, b), \sup_{b \in B} \inf_{a \in A} d(a, b) \right) \xrightarrow{P} 0
$$

Here, the sets $A$ and $B$ are the sets of component parameters $\{ (\mu_k, \sigma_k, w_k) \}_{k=1}^K$.

### Minimum-Matching Distance

To prove Hausdorff consistency, the paper utilizes a minimum-matching distance on permutation orbits. This distance metric minimizes the sum of distances between matched components over all possible permutations $\pi$ of the labels $\{1, \dots, K\}$:

$$
D(\boldsymbol{\theta}, \boldsymbol{\theta}') = \min_{\pi} \sum_{k=1}^K \| (\mu_k, \sigma_k, w_k) - (\mu'_{\pi(k)}, \sigma'_{\pi(k)}, w'_{\pi(k)}) \|
$$

Convergence in this metric implies that the estimated mixture components are converging to the true components, disregarding the arbitrary labeling.

### Penalized Likelihood and Coercivity

A known issue in GMMs is the unbounded likelihood when $\sigma_k \to 0$ for some component centered on a data point ("variance collapse"). The paper addresses this by introducing a **penalized likelihood**:

$$
\ell_{pen}(\boldsymbol{\theta}) = \ell_n(\boldsymbol{\theta}) - \text{Penalty}(\boldsymbol{\theta})
$$

*   **Penalty Function**: A quadratic penalty in location ($\mu_k$) and log-scale ($\ln \sigma_k$) is shown to dominate the "spike bonus" from variance collapse. This makes the penalized likelihood **coercive**, ensuring the existence of a global maximum.
*   **Consistency**: When the penalty term shrinks (regularization parameter $\lambda_n \to 0$) but not too fast (specifically $n \lambda_n \to \infty$), the penalized estimators remain consistent.

This approach provides a robust framework for estimating mixture models without the pathological behavior associated with unconstrained MLE.
