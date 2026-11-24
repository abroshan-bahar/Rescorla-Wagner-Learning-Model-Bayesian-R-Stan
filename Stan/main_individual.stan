data{
  int<lower=1> nTrials;
  int<lower=1> nBlocks;
  int<lower=1> nCards;

  array[nTrials] int<lower=1, upper=nBlocks> block;
  array[nTrials] int<lower=1, upper=nCards> card_left;
  array[nTrials] int<lower=1, upper=nCards> card_right;
  array[nTrials] int<lower=0, upper=1> choice;
  array[nTrials] real reward;
}
parameters{
  real<lower=0, upper=1> lr;
  real<lower=0> tau;
}
model{
  vector[nCards] Q;
  real PE;
  int chosen;

  // Priors
  lr ~ beta(1, 1);
  tau ~ normal(0, 3);

  // Initialize card values
  Q = rep_vector(0, nCards);

  for (t in 1:nTrials) {

    // Reset card values at the beginning of a new block
    if (t > 1) {
      if (block[t] != block[t-1]) {
        Q = rep_vector(0, nCards);
      }
    }

    // Choice rule
    choice[t] ~ bernoulli_logit(
      tau * (Q[card_right[t]] - Q[card_left[t]])
    );

    // Identify the chosen card
    if (choice[t] == 1) {
      chosen = card_right[t];
    } else {
      chosen = card_left[t];
    }

    // Calculate prediction error
    PE = reward[t] - Q[chosen];

    // Update the value of the chosen card
    Q[chosen] = Q[chosen] + lr * PE;
  }
}
