import matplotlib.pyplot as plt
import numpy as np
import json
f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerData.json')
data = json.load(f)


def returnDataEntry(data, participant, task, layout, feedbackType, trial):
    return data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'FeedbackType '+str(feedbackType)]['Trial '+str(trial)]


feedback_time = [0]*4
feedback_errors = [0]*4
for participant in range(1, 16):
    for feedback_type in range(1, 5):
        for trial in range(1, 4):
            feedback_time[feedback_type-1] = feedback_time[feedback_type-1] + int(returnDataEntry(data, participant, 2, -
                                                                                                  1, feedback_type, trial)['Time'])/(1000*15*3)
            feedback_errors[feedback_type-1] = feedback_errors[feedback_type-1] + int(returnDataEntry(data, participant, 2, -
                                                                                                      1, feedback_type, trial)['Errors'])/(15*3)


# Create sample data
x = np.array([1, 2, 3, 4])
y_location_times = np.array(feedback_time)
y_location_errors = np.array(feedback_errors)


# Create a figure with two subplots
fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 4))
fig.suptitle("Younger Participants", fontsize=15)

# Plot the first subplot
axs[0].bar(x, y_location_times, width=0.4,
           color='black', align='center')
axs[0].set_title('Average time per Feedback Type')
axs[0].set_xlabel('Button Feedback Type')
axs[0].xaxis.set_label_coords(.5, -.1)
axs[0].set_ylabel('Task Completion Time (Seconds)')
axs[0].set_xticks(x)
axs[0].set_ylim(0, 3.2)
axs[0].set_xticklabels(['None', 'Audio', 'Vibration',
                       'AudioTactile'])

for i, v in enumerate(y_location_times):
    axs[0].text(i+.8, v*1.01,
                str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)

# Plot the second subplot
axs[1].bar(x, y_location_errors, width=0.4,
           color='black', align='center')

axs[1].set_title('Average Errors per Feedback Type')
axs[1].set_xlabel('Button Feedback Type')
axs[1].xaxis.set_label_coords(.5, -.1)
axs[1].set_ylabel('Number of Errors')
axs[1].set_xticks(x)
axs[1].set_ylim(0, 1.2)
axs[1].set_xticklabels(['None', 'Audio', 'Vibration',
                       'AudioTactile'])

for i, v in enumerate(y_location_errors):
    axs[1].text(i+.8, v*1.01,
                str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)


# Adjust spacing between subplots
fig.tight_layout()

# Show the figure
plt.show()
