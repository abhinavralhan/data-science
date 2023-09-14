library(rstan)

D <- c(-0.6, 0.2, -0.8, 1.6, 0.3)

p1 <- 0
p2 <- 2

model <- stan(model_code = " 
data {
 vector[4] D;
 real p1;
 real p2;
}
parameters{
 real mu;
 real <lower=0> sigma;
} 

model{
 mu ~ normal(p1, p2);
 sigma ~ uniform(0, 5);
 D ~ normal(mu, sigma);
}
", data = list(D = D, p1 = p1, p2 = p2))

samples <- extract(model)

#Comparable to the result in the previous slides.
plot(samples$sigma)