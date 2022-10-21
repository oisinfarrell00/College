import random
from matplotlib.lines import Line2D
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('U:\\Fifth-Year\\Data Viz\\Assignment 1.3\\gapminder.csv')

continents = data["continent"]
years = data["year"]
life_expectencies = data["lifeExp"]

orientation = []
for continent in continents:
    if continent == "Africa": 
        orientation.append(0)
    elif continent == "Americas":
        orientation.append(90) 
    elif continent == "Asia":
        orientation.append(180) 
    elif continent == "Europe":
        orientation.append(270) 
    else:
        orientation.append(105)

plt.rcParams["figure.figsize"] = (20, 10)
plt.style.use("seaborn-v0_8-dark")
for i in range(len(orientation)):
    scatter = plt.scatter(random.uniform(years[i]-1.5, years[i]+2.5),
                          life_expectencies[i], marker=(3, 0, orientation[i]), c='red', edgecolors='black', linewidths=0.25, s=190)

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

legend_elements = [Line2D([0], [0], marker=(3, 0, 0), color='w', label='Africa',
                          markerfacecolor='red', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker=(3, 0, 90), color='w', label='Americas',
                          markerfacecolor='red', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker=(3, 0, 180), color='w', label='Asia',
                          markerfacecolor='red', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker=(3, 0, 270), color='w', label='Europe',
                          markerfacecolor='red', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker=(3, 0, 105), color='w', label='Oceanic',
                          markerfacecolor='red', markersize=15, markeredgecolor='black'),
                   ]

plt.legend(handles=legend_elements, loc='lower right')
plt.show()
