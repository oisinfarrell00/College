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

colors = []
for continent in continents:
    if continent == "Africa":
        colors.append("#1ECBE1")
    elif continent == "Americas":
        colors.append("#E1341E")
    elif continent == "Asia":
        colors.append("#3CF20D")
    elif continent == "Europe":
        colors.append("#C30DF2")
    else:
        colors.append("#000000")

plt.rcParams["figure.figsize"] = (100, 50)
plt.style.use("seaborn-v0_8-dark")
for i in range(len(colors)):
    scatter = plt.scatter(random.uniform(years[i]-1.5, years[i]+2.5),
                          life_expectencies[i], marker='o', c=colors[i], edgecolors='black', linewidths=0.25)

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

legend_elements = [Line2D([0], [0], marker='o', color='w', label='Africa',
                          markerfacecolor='#1ECBE1', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='Americas',
                          markerfacecolor='#E1341E', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='Asia',
                          markerfacecolor='#3CF20D', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='Europe',
                          markerfacecolor='#C30DF2', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='Oceanic',
                          markerfacecolor='#000000', markersize=15, markeredgecolor='black'),
                   ]

plt.legend(handles=legend_elements, loc='lower right')
plt.show()
