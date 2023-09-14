library(rethinking)
set.seed(1)
N <- 200

# Party or not.
P <- rbinom(N, 1, 0.5)

# Assignment mechanisms now influenced by the party.
A <- rbinom(N, 1, ifelse(P, 0.9, 0.1))

# We simulate headache caused by party and taking no aspirin.
mu <- -0.3 + 0.3 * P - 0.2 * A
sigma <- 0.07

H <- rnorm(N, mu, sigma)

# What do we want to KNOW and what do we have?

model1 <- quap(alist(
  H ~ dnorm(mu, sigma),
  mu <- a + bA * A,
  sigma ~ dunif(0, 3),
  a ~ dnorm(0, 1),
  bA ~ dnorm(0, 1)
), data = list(A = A, H = H))

posterior1 <- extract.samples(model1)

par(mfcol = c(1, 1))
hist(posterior1$bA, breaks = 20, xlim = c(-0.3, 0.2), main = round(mean(posterior1$bA), 3))
#hist(posterior2$bA, breaks = 20, xlim = c(-0.3, 0.2), main = round(mean(posterior2$bA), 3))