import matplotlib.pyplot as plt
import numpy as np
import json
f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdults.json')
data = json.load(f)


def returnDataEntry(data, participant, task, layout, feedbackType, trial):
    return data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'Feedback '+str(feedbackType)]['Trial '+str(trial)]


location_chosen = [0]*8
location_time = [0]*8
location_errors = [0]*8
for participant in range(1, 16):
    for layout in range(1, 7):
        times = []
        for trial in range(1, 4):
            location_index = (int(returnDataEntry(data, participant,
                                                  1, layout, 1, trial)['Position']))

            if(location_index) > 3:
                location_index = location_index - 1
            location_chosen[location_index] = location_chosen[location_index] + 1
            location_time[location_index] = location_time[location_index] + int(returnDataEntry(data, participant,
                                                                                                1, layout, 1, trial)['Time'])/(1000)
            location_errors[location_index] = location_errors[location_index] + int(returnDataEntry(data, participant,
                                                                                                    1, layout, 1, trial)['Errors'])

per_location_times = [0]*8
per_location_errors = [0]*8
for i in range(0, 8):
    per_location_times[i] = location_time[i]/location_chosen[i]
    per_location_errors[i] = location_errors[i]/location_chosen[i]

# Create sample data
x = np.array([1, 2, 3, 4, 5, 6, 7, 8])
y_location_times = np.array(per_location_times)
y_location_errors = np.array(per_location_errors)


# Create a figure with two subplots
fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 4))

# Plot the first subplot
axs[0].bar(x, y_location_times, width=0.4,
           color='black', align='center')
axs[0].set_title('Average time per location')
axs[0].set_xlabel('Button Location')
axs[0].xaxis.set_label_coords(.5, -.1)
axs[0].set_ylabel('Task Completion Time (Seconds)')
axs[0].set_xticks(x)
axs[0].set_xticklabels(['NW', 'N', 'NE',
                       'W', 'E', 'SW',
                        'S', 'SE'])

for i, v in enumerate(y_location_times):
    axs[0].text(i+.8, v*1.01,
                str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)

# Plot the second subplot
axs[1].bar(x, y_location_errors, width=0.4,
           color='black', align='center')

axs[1].set_title('Average Errors per Location')
axs[1].set_xlabel('Button Location')
axs[1].xaxis.set_label_coords(.5, -.1)
axs[1].set_ylabel('Number of Errors')
axs[1].set_xticks(x)
axs[1].set_xticklabels(['NW', 'N', 'NE',
                       'W', 'E', 'SW',
                        'S', 'SE'])

for i, v in enumerate(y_location_errors):
    axs[1].text(i+.8, v*1.01,
                str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)


# Adjust spacing between subplots
fig.tight_layout()

# Show the figure
plt.show()
