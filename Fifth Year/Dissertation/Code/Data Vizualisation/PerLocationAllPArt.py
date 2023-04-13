import matplotlib.pyplot as plt
import numpy as np
import json

f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdults.json')
data_older = json.load(f)

f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerData.json')
data_younger = json.load(f)

def returnDataEntry(data, participant, task, layout, feedbackType, trial):
    return data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'FeedbackType '+str(feedbackType)]['Trial '+str(trial)]

TITLE_SIZE = 20
LABEL_SIZE = 15

location_chosen = [0]*8
location_time = [0]*8
location_errors = [0]*8
for participant in range(1, 16):
    for layout in range(1, 7):
        for trial in range(1, 4):
            location_index = (int(returnDataEntry(data_older, participant,
                                                  1, layout, -1, trial)['Position']))
            location_chosen[location_index] = location_chosen[location_index] + 1
            location_time[location_index] = location_time[location_index] + int(returnDataEntry(data_older, participant,
                                                                                                1, layout, -1, trial)['Time'])/(1000)
            location_errors[location_index] = location_errors[location_index] + int(returnDataEntry(data_older, participant,
                                                                                                    1, layout, -1, trial)['Errors'])
            
location_chosen_younger = [0]*8
location_time_younger = [0]*8
location_errors_younger = [0]*8
for younger_participant in range(1, 16):
    for layout in range(1, 7):
        for trial in range(1, 4):
            location_index = (int(returnDataEntry(data_younger, younger_participant,
                                                  1, layout, -1, trial)['Position']))
            location_chosen_younger[location_index] = location_chosen[location_index] + 1
            location_time_younger[location_index] = location_time[location_index] + int(returnDataEntry(data_younger, younger_participant,
                                                                                                1, layout, -1, trial)['Time'])/(1000)
            location_errors_younger[location_index] = location_errors[location_index] + int(returnDataEntry(data_younger, younger_participant,
                                                                                                    1, layout, -1, trial)['Errors'])

per_location_times = [0]*8
per_location_errors = [0]*8
per_location_times_younger = [0]*8
per_location_errors_younger = [0]*8
for i in range(0, 8):
    per_location_times[i] = location_time[i] / location_chosen[i]
    per_location_errors[i] = location_errors[i] / location_chosen[i]
    per_location_times_younger[i] = location_time_younger[i] / location_chosen_younger[i]
    per_location_errors_younger[i] = location_errors_younger[i] / location_chosen_younger[i]

# Create sample data
barWidth = 0.25
x = np.array([1, 2, 3, 4, 5, 6, 7, 8])
br1 = np.arange(len(per_location_times))
br2 = [x + barWidth for x in br1]
br3 = [x + barWidth for x in br2]
y_location_times = np.array(per_location_times)
y_location_errors = np.array(per_location_errors)
y_location_times_younger = np.array(per_location_times_younger)
y_location_errors_younger = np.array(per_location_errors_younger)
y_location_times_comp = np.array([1.93, 1.47, 1.77, 1.57, 1.44, 1.61, 1.65, 1.8])
y_location_errors_comp = np.array([.92, .53,  .74, .53, .48, .68, .58, .7])


# Create a figure with two subplots
fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 4))
fig.suptitle('Task Completion Time and Errors by Location', fontsize=20)

# Plot the first subplot
axs[0].bar(br1, y_location_times, width=barWidth,
           color='black', align='center', label="Older Participants (2023)")
axs[0].bar(br2, y_location_times_younger, width=barWidth,
           color='grey', align='center', label="Younger Participants (2023)")
axs[0].bar(br3, y_location_times_comp, width=barWidth,
           color='red', align='center', label="Older Participants (2013)")
axs[0].set_title('Average Task Completion Time', fontsize = TITLE_SIZE)
axs[0].set_ylim([0, 2.8])
axs[0].set_xlabel('Button Location', fontsize = LABEL_SIZE)
axs[0].xaxis.set_label_coords(.5, -.1)
axs[0].set_ylabel('Task Completion Time (Seconds)', fontsize = LABEL_SIZE)
for tick in axs[0].yaxis.get_major_ticks():
                tick.label.set_fontsize(15) 
for tick in axs[0].xaxis.get_major_ticks():
                tick.label.set_fontsize(15)
axs[0].set_xticks([r + barWidth for r in range(len(per_location_errors))])
axs[0].set_xticklabels(['NW', 'N', 'NE',
                       'W', 'E', 'SW',
                        'S', 'SE'])
axs[0].legend()
axs[0].legend(prop={'size': 12})


# Plot the second subplot
axs[1].bar(br1, y_location_errors, width=barWidth,
           color='black', align='center', label="Older Participants (2023)")
axs[1].bar(br2, y_location_errors_younger, width=barWidth,
           color='grey', align='center', label="Younger Participants (2023)")
axs[1].bar(br3, y_location_errors_comp, width=barWidth,
           color='red', align='center', label="Older Participants (2013)")
axs[1].set_title('Average Number of Errors', fontsize = TITLE_SIZE)
axs[1].set_xlabel('Button Location', fontsize = LABEL_SIZE)
for tick in axs[1].yaxis.get_major_ticks():
                tick.label.set_fontsize(15)
for tick in axs[1].xaxis.get_major_ticks():
                tick.label.set_fontsize(15) 
axs[1].xaxis.set_label_coords(.5, -.1)
axs[1].set_ylabel('Number of Errors', fontsize = LABEL_SIZE)
axs[1].set_xticks([r + barWidth for r in range(len(per_location_errors))])
axs[1].set_xticklabels(['NW', 'N', 'NE',
                       'W', 'E', 'SW',
                        'S', 'SE'])
axs[1].legend(prop={'size': 12})


# Adjust spacing between subplots
fig.tight_layout()

# Show the figure
plt.show()
