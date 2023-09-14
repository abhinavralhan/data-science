library(rethinking)
set.seed(1)
N <- 200

# Assignment mechanisms (Aspirin or not).
A <- rbinom(N, 1, 0.5)

# We simulate the mediator.
M <- rnorm(N, -0.1 * A, 0.1)

mu <- -0.4 + M - 0.1 * A
sigma <- 0.07

H <- rnorm(N, mu, sigma)

# What do we want to KNOW and what do we have?

model <- quap(alist(
  H ~ dnorm(mu, sigma),
  mu <- a + bA * A,
  sigma ~ dunif(0, 3),
  a ~ dnorm(0, 1),
  bA ~ dnorm(0, 1)
), data = list(A = A, H = H))

posterior <- extract.samples(model)

par(mfcol = c(1, 1))
hist(posterior$bA, breaks = 20, xlim = c(-0.3, 0.0))