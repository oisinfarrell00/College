import math

import matplotlib.pyplot as plt
import pandas as pd

data = pd.read_csv('U:\\Fifth-Year\\Data Viz\\Assignment 1.3\\gapminder.csv')

population = data["pop"]
gdpPercap = data["gdpPercap"]
life_expectencies = data["lifeExp"]

plt.rcParams["figure.figsize"] = (30, 10)

gdpPercapLog = []
for gdp in gdpPercap:
    gdpPercapLog.append(math.log(gdp, 10))

popLog = []
for pop in population:
    popLog.append(math.log(pop, 10))

plt.style.use("seaborn-v0_8")
cm = plt.cm.get_cmap('YlGn')
scatter = plt.scatter(gdpPercapLog,
                      life_expectencies, marker='o', c=popLog, vmin=4, vmax=10, s=60, cmap=cm, edgecolors='black', linewidths=0.25)

plt.title("Life Expectency vs log10(GDP)")
plt.xlabel("log10(GDP)")
plt.ylabel("Life Expenctency")

cbar = plt.colorbar(scatter, label="Log10(Population)")
plt.show()