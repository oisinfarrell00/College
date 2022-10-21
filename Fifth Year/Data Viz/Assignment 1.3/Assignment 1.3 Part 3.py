import math
import random
from matplotlib.lines import Line2D
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv('U:\\Fifth-Year\\Data Viz\\Assignment 1.3\\gapminder.csv')
continents = data["continent"]
years = data["year"]
population = data["pop"]
gdpPercap = data["gdpPercap"]
life_expectencies = data["lifeExp"]

def convert_dgp_to_size(gdp):
    OldRange = (113523.1329 - 241.1658765)
    NewRange = (1200 - 30)
    return(((gdp - 241.1658765) * NewRange) / OldRange) + 30

data = [[0]*4]*len(continents)

africa_years=[]
americas_years=[]
asia_years=[]
europe_years=[]
oceanic_years=[]

africa_life=[]
americas_life=[]
asia_life=[]
europe_life=[]
oceanic_life=[]

africa_pop=[]
americas_pop=[]
asia_pop=[]
europe_pop=[]
oceanic_pop=[]

africa_gdp=[]
americas_gdp=[]
asia_gdp=[]
europe_gdp=[]
oceanic_gdp=[]

for i in range(len(continents)):
    if continents[i] == "Africa":
        africa_years.append(years[i]+random.uniform(-1.5, 2.5))
        africa_life.append(life_expectencies[i])
        africa_pop.append(math.log(population[i], 10))
        africa_gdp.append(convert_dgp_to_size(gdpPercap[i]))
    elif continents[i] == "Americas":
        americas_years.append(years[i]+random.uniform(-1.5, 2.5))
        americas_life.append(life_expectencies[i])
        americas_pop.append(math.log(population[i], 10))
        americas_gdp.append(convert_dgp_to_size(gdpPercap[i]))
    elif continents[i] == "Asia":
        asia_years.append(years[i]+random.uniform(-1.5, 2.5))
        asia_life.append(life_expectencies[i])
        asia_pop.append(math.log(population[i], 10))
        asia_gdp.append(convert_dgp_to_size(gdpPercap[i]))
    elif continents[i] == "Europe":
        europe_years.append(years[i]+random.uniform(-1.5, 2.5))
        europe_life.append(life_expectencies[i])
        europe_pop.append(math.log(population[i], 10))
        europe_gdp.append(convert_dgp_to_size(gdpPercap[i]))
    else:
        oceanic_years.append(years[i]+random.uniform(-1.5, 2.5))
        oceanic_life.append(life_expectencies[i])
        oceanic_pop.append(math.log(population[i], 10))
        oceanic_gdp.append(convert_dgp_to_size(gdpPercap[i]))


plt.rcParams["figure.figsize"] = (200, 100)
plt.style.use("seaborn-v0_8-dark")

cm = plt.cm.get_cmap('YlGn')
scatter = plt.scatter(africa_years, africa_life,
        marker='*', c=africa_pop, linewidths=0.2, edgecolors='black', s=africa_gdp, vmin=4, vmax=10, cmap=cm)
scatter = plt.scatter(americas_years, americas_life,
        marker='s', c=americas_pop, linewidths=0.2, edgecolors='black', s=americas_gdp, vmin=4, vmax=10, cmap=cm)
scatter = plt.scatter(asia_years, asia_life,
        marker='$X$', c=asia_pop, linewidths=0.2, edgecolors='black', s=asia_gdp, vmin=4, vmax=10, cmap=cm)
scatter = plt.scatter(europe_years, europe_life,
        marker='^', c=europe_pop, linewidths=0.2, edgecolors='black', s=europe_gdp, vmin=4, vmax=10, cmap=cm)
scatter = plt.scatter(oceanic_years, oceanic_life,
        marker='^', c=oceanic_pop, linewidths=0.2, edgecolors='black', s=oceanic_gdp, vmin=4, vmax=10, cmap=cm,)

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

legend_elements = [Line2D([0], [0], marker='*', color='w', label='Africa',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='s', color='w', label='Americas',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='$X$', color='w', label='Asia',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='^', color='w', label='Europe',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='o', color='w', label='Oceanic',
                          markerfacecolor='black', markersize=15),
                   Line2D([0], [0], marker='*', color='w', markeredgecolor='black', label='Min gdpPerCap: 241.1658765',
                          markerfacecolor='black', markersize=10),
                   Line2D([0], [0], marker='$X$', color='w', markeredgecolor='black', label='Max gdpPerCap: 113523.1329\nNote: Gdp given by size.',
                          markerfacecolor='black', markersize=30),
                   ]

legend = plt.legend(handles=legend_elements,
                    loc='lower right', bbox_to_anchor=(0.001, .8))
cbar = plt.colorbar(scatter, label="Log10(Population)")                    
plt.show()