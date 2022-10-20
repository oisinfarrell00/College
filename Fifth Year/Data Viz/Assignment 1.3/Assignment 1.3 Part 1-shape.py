from cProfile import label
from random import randrange
import random
from matplotlib import markers
from matplotlib.lines import Line2D
from matplotlib.patches import Patch
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('U:\\Fifth-Year\\Data Viz\\Assignment 1.3\\gapminder.csv')

countries = data["country"]
continents = data["continent"]
years = data["year"]
population = data["pop"]
gdpPercap = data["gdpPercap"]
life_expectencies = data["lifeExp"]

shapes = []
for continent in continents:
    if continent == "Africa":
        shapes.append("*")
    elif continent == "Americas":
        shapes.append("$A$")
    elif continent == "Asia":
        shapes.append("$X$")
    elif continent == "Europe":
        shapes.append("$U$")
    else:
        shapes.append("$M$")

plt.rcParams["figure.figsize"] = (20, 10)
plt.style.use("seaborn-v0_8-dark")
for i in range(len(shapes)):
    scatter = plt.scatter(random.uniform(years[i]-1.5, years[i]+2.5),
                          life_expectencies[i], marker=shapes[i], s=100, c='#088da5', edgecolors='black', linewidths=0.25)

for i in range(1950, 2015, 5):
    plt.axvline(x=i, color='k', label='axvline - full height')

plt.title("Life Expectency vs Year")
plt.xlabel("Year")
plt.ylabel("Life Expenctency")

x_ticks = [1952, 1957, 1962, 1967, 1972,
           1977, 1982, 1987, 1992, 1997, 2002, 2007]

x_labels = ['1952', '1957', '1962', '1967', '1972',
            '1977', '1982', '1987', '1992', '1997', '2002', '2007']

plt.xticks(ticks=x_ticks, labels=x_labels)

legend_elements = [Line2D([0], [0], marker='*', color='w', label='Africa',
                          markerfacecolor='#088da5', markersize=17, markeredgecolor='black'),
                   Line2D([0], [0], marker='$A$', color='w', label='Americas',
                          markerfacecolor='#088da5', markersize=17, markeredgecolor='black'),
                   Line2D([0], [0], marker='$X$', color='w', label='Asia',
                          markerfacecolor='#088da5', markersize=17, markeredgecolor='black'),
                   Line2D([0], [0], marker='$U$', color='w', label='Europe',
                          markerfacecolor='#088da5', markersize=17, markeredgecolor='black'),
                   Line2D([0], [0], marker='$M$', color='w', label='Oceanic',
                          markerfacecolor='#088da5', markersize=17, markeredgecolor='black'),
                   ]

plt.legend(handles=legend_elements, loc='lower right')
plt.show()
