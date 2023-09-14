library(rethinking)
set.seed(1)
N <- 200

# Party or not.
P <- rbinom(N, 1, 0.5)

# Assignment mechanisms (Aspirin or not).
A <- rbinom(N, 1, 0.5)

# We simulate headache caused by taking no aspirin and party.
mu <- -0.3 + 0.3 * P - 0.2 * A
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