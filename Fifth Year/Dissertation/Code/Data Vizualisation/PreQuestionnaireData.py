import matplotlib.pyplot as plt
import numpy as np

plt.title('Pre-Experiment Questionnaire')


# set width of bar
barWidth = 0.25

# set height of bar
older_adults = np.array([14/15, 250/14, 35/14, 43/14])
younger_adults = np.array([15/15, 2200/15, 105/15, 297/15])

# Set position of bar on X axis
br1 = np.arange(len(older_adults))
br2 = [x + barWidth for x in br1]


# Make the plot
plt.bar(br1, older_adults, color='black', width=barWidth,
        edgecolor='grey', label='Older Adults')
plt.bar(br2, younger_adults, color='grey', width=barWidth,
        edgecolor='grey', label='Younger Adults')

# Adding Xticks
plt.xticks([r + barWidth for r in range(len(older_adults))],
           ['Daily Uses', 'Pre-Installed App Usage', 'Non Pre-installed App Usage'])
plt.ylabel('Average', fontweight='bold', fontsize=15)

plt.legend(title="Cohort")
for i, v in enumerate(older_adults):
    plt.text(i, v*1.025,
             str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)
for i, v in enumerate(younger_adults):
    plt.text(i+.25, v*1.025,
             str("{:.2f}".format(v)), color='red', fontweight='bold', fontsize=7)
plt.show()
