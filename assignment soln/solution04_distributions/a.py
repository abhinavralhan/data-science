import numpy as np
import matplotlib.pyplot as plt

rates = [0.4, 1, 3]
ns = [1, 10, 100, 1000, 10000]

fig, axs = plt.subplots(len(rates), len(ns), sharex="col", dpi=700)
plt.tight_layout()

for i in range(0, len(rates)):
    for j in range(0, len(ns)):
        data = np.random.exponential(rates[i], ns[j])
        axs[i, j].hist(data, bins=20)

for j in range(0, len(ns)):
    axs[len(rates) - 1][j].set_xlabel("n = " + str(ns[j]))

for i in range(0, len(rates)):
    axs[i][0].set_ylabel("rate = " + str(rates[i]))

plt.show()
# plt.savefig('plot.pdf', dpi=200)
