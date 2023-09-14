# Loading library and data set.
library(rethinking)
library(rstan)

df <- read.csv("/Users/abhinavralhan/Desktop/UniKo/sem1/datasci/exam/material-2/D339.csv")

model <- stan(model_code = "
data{
  int<lower=0> N;
  vector[N] Y;
  vector[N] X1;
  vector[N] X2;
}

parameters{
  real alpha;
  real beta1;
  real beta2;
  real <lower=0, upper=4> sigma;
}

model{
  vector[N] mu;
  sigma ~ uniform(0, 4);
  alpha ~ uniform(-10, 10);
  beta1 ~ uniform(-10, 10);
  beta2 ~ uniform(-10, 10);
  for(n in 1:N){
    mu[n] = alpha + beta1 * X1[n] + beta2 * X2[n];
  }
  Y ~ normal(mu, sigma);
}"
  , data = list(Y = df$Y, X1 = df$X1, X2 = df$X2, N = length(df$Y)), chains = 1)

samples <- extract.samples(model)


hist(samples$beta1)

# Plotting the points.
plot(df$age, df$height, ylim = c(-20, 200))

# Plotting the regression lines.
ages <- seq(0, 100, length.out = 60)

for (i in 1:100) {
  mu <- samples$a[i] + samples$b1[i] * ages + samples$b2[i] * ages^2 + samples$b3[i] * ages^3
  lines(ages, mu, col = rgb(1, 0, 0, 0.2))
}
