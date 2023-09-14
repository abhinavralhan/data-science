library(rstan)
library(rethinking)

N <- 10 # 10 groups.
M <- 20 # Each group contains 20 friends.
# Group id.
F <- rep(1:N, each = M)
# Party or not (for N groups, they only go together).
P <- rbinom(N, 1, 0.5)
# Aspirin now influenced by the party P[F] (indexed access).
A <- rbinom(N * M, 1, ifelse(P[F], 0.9, 0.1))
# We simulate headache caused by party and taking no aspirin.
mu <- -0.3 + 0.3 * P[F] - 0.2 * A
sigma <- 0.07
H <- rnorm(N * M, mu, sigma)

model <- stan(model_code = "
data{
  int<lower=0> N;
  int<lower=0> M;
  int F[N*M];
  vector[N*M] H;
  vector[N*M] A;
}
parameters{
  real beta;
  real<lower=0> sigma;
  vector[N] ps;
} 
model{ 
  vector[N*M] mu;
  ps ~ normal(0,1);
  mu = beta * A + ps[F]; 
  H ~ normal(mu, sigma);
}"
, data = list(M = M, N = N, F = F, H=H, A=A), chains = 1)

samples <- extract.samples(model)
