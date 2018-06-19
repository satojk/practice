import random
import numpy as np
import matplotlib.pyplot as plt

results = np.array([0] * 12)

for i in range(1000000):
    results[(random.randint(1, 6) + random.randint(1, 6)) - 1] += 1

plt.bar(x=range(12), height=results, align='center')
plt.show()

