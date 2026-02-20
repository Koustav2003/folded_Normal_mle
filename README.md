# Hausdorff consistency of MLE in folded normal and Gaussian mixtures

This repository contains theoretical derivations and R code implementations supporting the research paper:

**"Haussdorff consistency of MLE in folded normal and Gaussian mixtures"**
*Koustav Mallik*
arXiv:2509.12206

## Abstract

We develop a constant-tracking likelihood theory for two nonregular models: the folded normal and finite Gaussian mixtures. For the folded normal, we prove boundary coercivity for the profiled likelihood, show that the profile path of the location parameter exists and is strictly decreasing by an implicit-function argument, and establish a unique profile maximizer in the scale parameter. Deterministic envelopes for the log-likelihood, the score, and the Hessian yield elementary uniform laws of large numbers with finite-sample bounds, avoiding covering numbers. Identification and Kullback-Leibler separation deliver consistency. A sixth-order expansion of the log hyperbolic cosine creates a quadratic-minus-quartic contrast around zero, leading to a nonstandard one-fourth-power rate for the location estimator at the kink and a standard square-root rate for the scale estimator, with a uniform remainder bound.

For finite Gaussian mixtures with distinct components and positive weights, we give a short identifiability proof up to label permutations via Fourier and Vandermonde ideas, derive two-sided Gaussian envelopes and responsibility-based gradient bounds on compact sieves, and obtain almost-sure and high-probability uniform laws with explicit constants. Using a minimum-matching distance on permutation orbits, we prove Hausdorff consistency on fixed and growing sieves. We quantify variance-collapse spikes via an explicit spike-bonus bound and show that a quadratic penalty in location and log-scale dominates this bonus, making penalized likelihood coercive; when penalties shrink but sample size times penalty diverges, penalized estimators remain consistent.

## Repository Contents

*   `theory/`: Markdown documents detailing the theoretical framework, proofs (derived based on the abstract's claims), and mathematical properties of the Folded Normal and Gaussian Mixture models.
*   `code/`: R scripts implementing the Folded Normal model, Maximum Likelihood Estimation (MLE), profile likelihood visualization, and convergence rate simulations.

## Running the Code

To replicate the simulations and visualizations, run the following R scripts:

1.  **Convergence Rates**:
    ```bash
    Rscript code/simulation_rates.R
    ```
    This will generate `convergence_rates.png` showing the $n^{-1/4}$ rate for $\hat{\mu}$ and $n^{-1/2}$ rate for $\hat{\sigma}$.

2.  **Profile Likelihood**:
    ```bash
    Rscript code/profile_visualization.R
    ```
    This will generate `profile_likelihood.png` illustrating the "kink" at $\mu=0$ and the strictly decreasing profile path.

## Key Theoretical Contributions

*   **Folded Normal**:
    *   Boundary coercivity of profile likelihood.
    *   Strictly decreasing profile path for the location parameter.
    *   Non-standard $n^{1/4}$ convergence rate for the location estimator at the kink ($\mu=0$).
*   **Gaussian Mixtures**:
    *   Identifiability via Fourier and Vandermonde methods.
    *   Hausdorff consistency on sieves.
    *   Penalization strategies to handle variance-collapse spikes.

## Citation

If you use the code or theoretical derivations in this repository, please cite the original paper:

```bibtex
@article{mallik2025haussdorff,
  title={Haussdorff consistency of MLE in folded normal and Gaussian mixtures},
  author={Mallik, Koustav},
  journal={arXiv preprint arXiv:2509.12206},
  year={2025},
  url={https://arxiv.org/abs/2509.12206}
}
```

## License

This work is licensed under a [Creative Commons Attribution 4.0 International License](LICENSE).
