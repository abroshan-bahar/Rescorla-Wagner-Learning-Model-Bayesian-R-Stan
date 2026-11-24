# Bayesian Reinforcement Learning with R and Stan

## Project Overview

This project implements a Bayesian reinforcement learning model to investigate human decision-making and reward-based learning using empirical behavioral data.

The model combines the Rescorla–Wagner learning rule with a softmax choice function to estimate individual cognitive parameters from observed trial-level choices and outcomes.

## Research Objectives

- Implement computational models of human reinforcement learning.
- Estimate individual learning rates and inverse-temperature parameters using Bayesian inference.
- Investigate learning dynamics in a multi-armed bandit task.
- Extend the individual-level model to hierarchical Bayesian modeling.

## Dataset

The project uses publicly available behavioral data from Ben-Artzi et al. (2023), obtained from the Dryad Digital Repository.

Dataset DOI: https://doi.org/10.5061/dryad.d51c5b08d

Additional information and references are available in `Data/README.md`.

## Computational Model

The current model implements:

- Rescorla–Wagner value updating
- Reward prediction error
- Softmax choice probabilities
- Bayesian parameter estimation
- Block-specific value initialization

The two estimated parameters are:

| Parameter | Interpretation |
|---|---|
| Learning rate (α) | Sensitivity to new reward information |
| Inverse temperature (τ) | Sensitivity of decisions to differences in learned values |

## Repository Structure

- `Data/` — Behavioral dataset and documentation
- `R/01_explore_data.R` — Exploring data
- `R/02_prepare_data.R` — Data preprocessing
- `R/03_main_individual.R` — Individual-level Bayesian model fitting
- `Stan/main_individual.stan` — Reinforcement learning model specification

## Software and Dependencies

- R
- RStan
- Stan
- Git and GitHub

Install the required R package:

```r
install.packages("rstan")
```

A compatible C++ toolchain is also required for Stan model compilation.

## Usage

Run the following scripts from the repository root:

```r
source("R/01_explore_data.R")
source("R/02_prepare_data.R")
source("R/03_main_individual.R")
```

## Project Status

Work in progress.

- [x] Data exploration
- [x] Data preprocessing
- [x] Individual-level model implementation
- [ ] Model convergence assessment
- [ ] Posterior predictive checks
- [ ] Parameter recovery
- [ ] Hierarchical Bayesian modeling
- [ ] Model comparison


## References

Ben-Artzi, I., Kessler, Y., Nicenboim, B., & Shahar, N. (2023). Computational mechanisms underlying latent value updating of unchosen actions. *Science Advances, 9*(42), eadi2704. https://doi.org/10.1126/sciadv.adi2704

Rescorla, R. A., & Wagner, A. R. (1972). A theory of Pavlovian conditioning: Variations in the effectiveness of reinforcement and nonreinforcement.

## Acknowledgments

The initial modeling approach was informed by the BayesCog course: https://alpn-lab.github.io/BayesCog/

This project is an independent educational analysis of publicly available behavioral data and is not an exact reproduction of the original publication.