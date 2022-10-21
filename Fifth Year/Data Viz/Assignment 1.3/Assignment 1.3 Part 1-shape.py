import random
from matplotlib.lines import Line2D
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('U:\\Fifth-Year\\Data Viz\\Assignment 1.3\\gapminder.csv')

continents = data["continent"]
years = data["year"]
life_expectencies = data["lifeExp"]

shapes = []
for continent in continents:
    if continent == "Africa":
        shapes.append("*")
    elif continent == "Americas":
        shapes.append("s")
    elif continent == "Asia":
        shapes.append("$X$")
    elif continent == "Europe":
        shapes.append("^")
    else:
        shapes.append("o")

plt.rcParams["figure.figsize"] = (20, 10)
plt.style.use("seaborn-v0_8-dark")
for i in range(len(shapes)):
    scatter = plt.scatter(random.uniform(years[i]-1.5, years[i]+2.5),
                          life_expectencies[i], marker=shapes[i], s=100, c='#ff6666', edgecolors='black', linewidths=0.25)

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
                          markerfacecolor='#ff6666', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='s', color='w', label='Americas',
                          markerfacecolor='#ff6666', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='$X$', color='w', label='Asia',
                          markerfacecolor='#ff6666', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='^', color='w', label='Europe',
                          markerfacecolor='#ff6666', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='Oceanic',
                          markerfacecolor='#ff6666', markersize=15, markeredgecolor='black'),
                   ]

plt.legend(handles=legend_elements, loc='lower right')
plt.show()
