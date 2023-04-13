import matplotlib.pyplot as plt

# Define the data for each pie chart
data = [[15], [8, 5, 2], [9, 5, 1], [15], [3, 2, 10], [5, 8, 2]]

# Define the labels for each pie chart
labels = [['Layout 6'],
          ['Audio', 'Tactile', 'Audiotatile'],
          ['Audio', 'Tactile', 'Audiotatile'],
          ['Layout 6'],
          ['Audio', 'Tactile', 'Audiotatile'],
          ['Audio', 'Tactile', 'Audiotatile']]

# Define the titles for each subplot
titles = ['Prefered Layout', 'Most Obvious Feedback', 'Prefered Feedback', 'Prefered Layout', 'Most Obvious Feedback', 'Prefered Feedback']

# Define the overall figure title
fig_title = 'Post Experiment questionnaire Results. Older Adults (Top) versus Younger Adults (Bottom)'

# Create the figure and subplots
fig, axs = plt.subplots(nrows=2, ncols=3, figsize=(10, 6))
plt.subplots_adjust(top=.8, bottom=0.0, hspace=.6, wspace=0.4)
fig.text(0.5, 0.85, 'Older Cohort', ha='center', fontsize=15, weight='bold')
fig.text(0.5, 0.38, 'Younger Cohort', ha='center', fontsize=15, weight='bold')

# Loop over each subplot and add a pie chart with labels and title
for i, ax in enumerate(axs.flat):
    ax.pie(data[i], labels=labels[i], autopct='%1.1f%%', textprops={'fontsize': 13})
    ax.set_title(titles[i], fontsize=15)

# Add a suptitle to the figure
fig.suptitle(fig_title, fontsize=20)

# Show the figure
plt.show()
