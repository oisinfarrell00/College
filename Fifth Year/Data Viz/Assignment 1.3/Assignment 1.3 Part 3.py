from cProfile import label
import math
from random import randrange
import random
from matplotlib import markers
from matplotlib.lines import Line2D
from matplotlib.patches import Patch
import pandas as pd
import matplotlib.pyplot as plt

# country,continent,year,lifeExp,pop,gdpPercap
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


def convert_dgp_to_size(gdp):
    OldRange = (113523.1329 - 241.1658765)
    NewRange = (1200 - 30)
    return(((gdp - 241.1658765) * NewRange) / OldRange) + 30


plt.style.use("seaborn-v0_8-dark")
for i in range(len(years)):
    color = '#000000'
    if population[i] < 100000: #1
        color = '#847E7B'
    elif  100000 < population[i] < 500000: #2
        color = '#FF0005'
    elif 500000 < population[i] < 1000000: #3
        color = '#FDF402'
    elif 1000000 < population[i] < 5000000: #4
        color = '#000000'
    elif 5000000 < population[i] < 10000000: #5
        color = '#71DE21'
    elif 10000000 < population[i] < 50000000: #6
        color = '#8E21DE'
    elif 50000000 < population[i] < 100000000: #7
        color = '#020BFD'
    elif 100000000 < population[i] < 500000000: #8 
        color = '#00FFFA'
    elif 500000000 < population[i] < 1000000000: #9 
        color = '#FFB900'
    elif population[i] > 100000000: #10
        color = '#FFFFFF'
    scatter = plt.scatter(random.uniform(
        years[i]-1.5, years[i]+2.5), life_expectencies[i],
        marker=shapes[i], c=color, linewidths=0.2, edgecolors='black', s=convert_dgp_to_size(gdpPercap[i]))


for i in range(1950, 2015, 5):
    plt.axvline(x=i, color='black', label='axvline - full height')

plt.title("Life Expectency vs Year")
plt.xlabel("Year")
plt.ylabel("Life Expecency")

x_ticks = [1952, 1957, 1962, 1967, 1972,
           1977, 1982, 1987, 1992, 1997, 2002, 2007]

x_labels = ['1952', '1957', '1962', '1967', '1972',
            '1977', '1982', '1987', '1992', '1997', '2002', '2007']

plt.xticks(ticks=x_ticks, labels=x_labels)

legend_elements = [Line2D([0], [0], marker='o', color='w', label='Population < 100000',
                          markerfacecolor='#847E7B', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='100000 < population < 500000',
                          markerfacecolor='#FF0005', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='500000 population < 1000000',
                          markerfacecolor='#FDF402', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='1000000 < population < 5000000',
                          markerfacecolor='#000000', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='5000000 < population < 10000000',
                          markerfacecolor='#71DE21', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='10000000 < population < 50000000',
                          markerfacecolor='#8E21DE', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='o', color='w', label='50000000 < population < 100000000',
                          markerfacecolor='#020BFD', markersize=15, markeredgecolor='black'),
                    Line2D([0], [0], marker='o', color='w', label='100000000 < population < 500000000',
                          markerfacecolor='#00FFFA', markersize=15, markeredgecolor='black'),
                    Line2D([0], [0], marker='o', color='w', label='500000000 < population < 1000000000',
                          markerfacecolor='#FFB900', markersize=15, markeredgecolor='black'),
                    Line2D([0], [0], marker='o', color='w', label='population > 100000000',
                          markerfacecolor='#FFFFFF', markersize=15, markeredgecolor='black'),
                   Line2D([0], [0], marker='*', color='w', label='Africa',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='$A$', color='w', label='Americas',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='$X$', color='w', label='Asia',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='$U$', color='w', label='Europe',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='$M$', color='w', label='Oceanic',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='*', color='w', markeredgecolor='black', label='Min gdpPerCap: 241.1658765',
                          markerfacecolor='blue', markersize=10),
                   Line2D([0], [0], marker='$X$', color='w', markeredgecolor='black', label='Max gdpPerCap: 113523.1329\nNote: Gdp given by size. \nThese are just examples',
                          markerfacecolor='red', markersize=30),
                   ]

legend = plt.legend(handles=legend_elements,
                    loc='lower right', bbox_to_anchor=(0.001, .6))
plt.show()
