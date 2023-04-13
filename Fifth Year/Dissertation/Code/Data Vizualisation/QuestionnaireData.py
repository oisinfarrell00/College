import matplotlib.pyplot as plt
import numpy as np
import json

# audio, tactile, aduiotactile
x = np.array([1, 2, 3])
obvious_feedback_old = np.array([8, 5, 2])
prefered_feedback_old = np.array([8, 5, 2])
obvious_feedback_young = np.array([3, 2, 10])
prefered_feedback_young = np.array([5, 8, 2])


# Create a figure with two subplots
fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 4))
fig.suptitle("Post Experiment Questionnaire", fontsize=15)

# Plot the first subplot
axs[0].bar(x-0.2, obvious_feedback_old, width=0.4,
           color='black', align='center', label='Older Adults')
axs[0].bar(x+0.2, obvious_feedback_young, width=0.4,
           color='grey', align='center', label='Younger Adults')
axs[0].set_title('Most Obvious Feedback Type')
axs[0].set_xlabel('Feedback Type')
axs[0].xaxis.set_label_coords(.5, -.1)
axs[0].set_ylabel('')
axs[0].set_xticks(x)
axs[0].set_xticklabels(['Audio', 'Tactile', 'Aduiotactile'])

axs[0].legend(title="Cohort")
for i, v in enumerate(obvious_feedback_old):
    axs[0].text(i+.65, v*1.01,
                str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)
for i, v in enumerate(obvious_feedback_young):
    axs[0].text(i+1.15, v*1.01,
                str("{:.2f}".format(v)), color='red', fontweight='bold', fontsize=7)

# Plot the second subplot
axs[1].bar(x-0.2, prefered_feedback_old, width=0.4,
           color='black', align='center', label='Older Adults')
axs[1].bar(x+0.2, prefered_feedback_young, width=0.4,
           color='grey', align='center', label='Younger Adults')
axs[1].set_title('Prefered Preference')
axs[1].set_xlabel('Feedback Type')
axs[1].xaxis.set_label_coords(.5, -.1)
axs[1].set_ylabel('Number of Errors')
axs[1].set_xticks(x)
axs[1].set_xticklabels(['Audio', 'Tactile', 'Audiotactile'])

axs[1].legend(title="Cohort")
for i, v in enumerate(prefered_feedback_old):
    axs[1].text(i+.65, v*1.01,
                str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)
for i, v in enumerate(prefered_feedback_young):
    axs[1].text(i+1.15, v*1.01,
                str("{:.2f}".format(v)), color='red', fontweight='bold', fontsize=7)

# Adjust spacing between subplots
fig.tight_layout()

# Show the figure
plt.show()
