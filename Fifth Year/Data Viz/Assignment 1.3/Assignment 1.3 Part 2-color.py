import math

import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.lines import Line2D

data = pd.read_csv('U:\\Fifth-Year\\Data Viz\\Assignment 1.3\\gapminder.csv')

population = data["pop"]
gdpPercap = data["gdpPercap"]
life_expectencies = data["lifeExp"]

plt.rcParams["figure.figsize"] = (20, 10)

for i in range(len(gdpPercap)):
    color = '#34aeeb'
    if population[i] < 100000:
        color = '#000000'
    elif population[i] > 100000 and population[i] < 1000000:
        color = '#C4AC9A'
    elif population[i] > 1000000 and population[i] < 10000000:
        color = '#88A376'
    elif population[i] > 10000000 and population[i] < 100000000:
        color = '#648787'
    elif population[i] > 100000000:
        color = '#FB9C74'

    plt.style.use("seaborn-v0_8")
    scatter = plt.scatter(math.log(gdpPercap[i], 10),
                          life_expectencies[i], marker='o', c=color, edgecolors='black', linewidths=0.25)


plt.title("Life Expectency vs GDP")
plt.xlabel("log(GDP)")
plt.ylabel("Life Expenctency")

legend_elements = [Line2D([0], [0], marker='o', color='w', label='<100000',
                          markerfacecolor='#000000', markersize=15),
                   Line2D([0], [0], marker='o', color='w', label='100000 - 1000000',
                          markerfacecolor='#C4AC9A', markersize=15),
                   Line2D([0], [0], marker='o', color='w', label='1000000 - 10000000',
                          markerfacecolor='#88A376', markersize=15),
                   Line2D([0], [0], marker='o', color='w', label='10000000 - 100000000',
                          markerfacecolor='#648787', markersize=15),
                   Line2D([0], [0], marker='o', color='w', label='>1000000000',
                          markerfacecolor='#FB9C74', markersize=15),
                   ]

plt.legend(handles=legend_elements, loc='lower right', title="Population")
plt.show()
