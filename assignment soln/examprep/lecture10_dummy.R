library(rstan)
library(rethinking)

N <- 10
P <- rbinom(N, 1, 0.5)
A <- rbinom(N, 1, prob = ifelse(P, 0.9, 0.1))

mu <- -0.3 + 0.3 * P - 0.2 * A
sigma <- 0.07
H <- rnorm(N, mu, sigma)

model <- stan(model_code = "
data{
  int<lower=0> N;
  vector[N] A;
  vector[N] P;
  vector[N] h;
}

parameters{
  real a;
  real ba;
  real bp;
  real <lower=0, upper=50> sigma;
}

model{
  vector[N] mu;
  sigma ~ uniform(0, 3);
  a ~ normal(0, 1);
  ba ~ normal(0, 1);
  bp ~ normal(0, 1);
  for(n in 1:N){
    mu[n] = a + ba * A[n] + bp * P[n];
  }
  h ~ normal(mu, sigma);
}"
, data = list(A = A, P = P, N = N, h=H), chains = 1)

samples <- extract.samples(model)
