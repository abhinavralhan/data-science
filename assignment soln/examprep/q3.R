library(rethinking)
set.seed(1)

df <- read.csv("/Users/abhinavralhan/Desktop/UniKo/sem1/datasci/assignment soln/examprep/D002.csv")

#model <- ulam(alist(
#  Y ~ dpois(lambda),
#  lambda <- exp(alpha + beta * X),
#  alpha ~ dunif("-10", 10),
#  beta ~ dunif("-10", 10)
#), data = list(X = df$X, Y = df$Y))
#samples <- extract.samples(model)


# Loading library and data set.
library(rethinking)
library(rstan)


model <- stan(model_code = "
data{
  int<lower=0> N;
  vector[N] X;
  int Y[N];
}
parameters{
  real a;
  real b;
}
model{
  vector[N] lambda;
  lambda = exp(a + b * X);
  Y ~ poisson(lambda);
}"
, data = list(Y = df$Y, X = df$X, N = length(df$X)), chains = 1)

samples <- extract.samples(model)

hist(samples$a)