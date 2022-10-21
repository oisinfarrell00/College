import math
from matplotlib.lines import Line2D
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('U:\\Fifth-Year\\Data Viz\\Assignment 1.3\\gapminder.csv')

population = data["pop"]
gdpPercap = data["gdpPercap"]
life_expectencies = data["lifeExp"]

plt.rcParams["figure.figsize"] = (20, 10)

def convert_pop_to_size(pop):
    OldRange = (1318683096 - 60011)
    NewRange = (5000 - 0.5)
    return(((pop - 60011) * NewRange) / OldRange) + 0.5

plt.style.use("seaborn-v0_8")
for i in range(len(gdpPercap)):
    scatter = plt.scatter(math.log(gdpPercap[i], 10),
                          life_expectencies[i], marker='o', s=convert_pop_to_size(population[i]), c='#679B9B', edgecolors='black')

plt.title("Life Expectency vs log10(GDP)")
plt.xlabel("log10(GDP)")
plt.ylabel("Life Expenctency")

legend_elements = [Line2D([0], [0], marker='o', color='w', markeredgecolor='black', label='Minimum Population: 60011',
                          markerfacecolor='#679B9B', markersize=2),
                   Line2D([0], [0], marker='o', color='w', label='  ',
                          markerfacecolor='#679B9B', markersize=0.5),
                   Line2D([0], [0], marker='o', color='w', label=' ',
                          markerfacecolor='#679B9B', markersize=0.5),
                   Line2D([0], [0], marker='o', color='w', label='',
                          markerfacecolor='#679B9B', markersize=0.5),
                   Line2D([0], [0], marker='o', color='w', markeredgecolor='black', label='            Maximum Population: 1318683096',
                          markerfacecolor='#679B9B', markersize=80),
                   Line2D([0], [0], marker='o', color='#679B9B', label='  ',
                          markerfacecolor='#679B9B', markersize=0.5),
                   Line2D([0], [0], marker='o', color='#679B9B', label=' ',
                          markerfacecolor='#679B9B', markersize=0.5),
                   ]

plt.legend(handles=legend_elements, loc='lower right', title="Population")
plt.show()