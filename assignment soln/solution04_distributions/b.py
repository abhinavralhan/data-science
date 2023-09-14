import numpy as np
import matplotlib.pyplot as plt

means = [-2, 0, 2]
sds = [1, 0.5, 0.1]

fig, axs = plt.subplots(len(means), len(sds), sharex="all", sharey="row", dpi=700)

for i in range(0, len(means)):
    for j in range(0, len(sds)):
        data = np.random.normal(means[i], sds[j], 10000)
        axs[i][j].hist(data, bins=30)

for i in range(0, len(means)):
    axs[i][0].set_ylabel("mean = " + str(means[i]))

for i in range(0, len(sds)):
    axs[len(means) - 1][i].set_xlabel("sds = " + str(sds[i]))

plt.show()
