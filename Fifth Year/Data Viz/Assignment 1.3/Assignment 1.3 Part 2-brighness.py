from cProfile import label
import math

import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.lines import Line2D

data = pd.read_csv('U:\\Fifth-Year\\Data Viz\\Assignment 1.3\\gapminder.csv')

population = data["pop"]
gdpPercap = data["gdpPercap"]
life_expectencies = data["lifeExp"]

plt.rcParams["figure.figsize"] = (20, 10)


def convert_pop_to_brightness(pop):
    OldRange = (1318683096 - 60011)
    NewRange = (16777215 - 0)
    newValue = int((((pop - 60011) * NewRange) / OldRange))
    numInHex = str(hex(newValue))[2:]
    return "#" + ("0"*(6-len(numInHex)))+numInHex


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


plt.title("Life Expectency vs log(GDP)")
plt.xlabel("log(GDP)")
plt.ylabel("Life Expenctency")

cbar = plt.colorbar(scatter, label="Log(Population)")
plt.show()
