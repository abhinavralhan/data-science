library(rstan)

set.seed(1)
N <- 200
W <- rnorm(N, mean = 70, sd = 10)
prob <- 1 / (1 + exp(-(-13 + 0.2 * W)))
# Covid
C <- rbinom(N, size = 1, prob = prob)

plot(W,C)


model <- stan(model_code = "
data{
 int<lower=0> N;
 vector[N] W;
 int<lower=0,upper=1> C[N];
}
parameters{
 real alpha;
 real beta;
}
model{
 C ~ bernoulli_logit(alpha + beta * W);
}
", data = list(N = N, W = W, C = C))

samples <- extract(model)

hist(samples$alpha)
hist(samples$beta)