import matplotlib.pyplot as plt
import numpy as np
import json
f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerData.json')
data = json.load(f)


def returnDataEntry(data, participant, task, layout, feedbackType, trial):
    return data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'Feedback '+str(feedbackType)]['Trial '+str(trial)]


trial_times_1mm = [0]*9
trial_times_3mm = [0]*9
index2 = 0
TASK1 = 1
for participant in range(1, 16):
    index = 0
    for trial in range(1, 4):
        for layout in range(1, 4):
            trial_times_1mm[index] = trial_times_1mm[index] + int(returnDataEntry(data, participant,
                                                                                  TASK1, layout, 0, trial)['Time'])/(1000*15)
            index = index + 1

    index = 0
    for trial in range(1, 4):
        for layout in range(4, 7):
            trial_times_3mm[index] = trial_times_3mm[index] + int(returnDataEntry(data, participant,
                                                                                  TASK1, layout, 0, trial)['Time'])/(1000*15)
            index = index + 1

trial_errors_1mm = [0]*9
trial_errors_3mm = [0]*9
TASK1 = 1
for participant in range(1, 16):
    index = 0
    for trial in range(1, 4):
        for layout in range(1, 4):
            trial_errors_1mm[index] = trial_errors_1mm[index] + int(returnDataEntry(data, participant,
                                                                                    TASK1, layout, 0, trial)['Errors'])/15
            index = index + 1

    index = 0
    for trial in range(1, 4):
        for layout in range(4, 7):
            trial_errors_3mm[index] = trial_errors_3mm[index] + int(returnDataEntry(data, participant,
                                                                                    TASK1, layout, 0, trial)['Errors'])/15
            index = index + 1


# Create sample data
x = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
y_trial_times_1mm = np.array(trial_times_1mm)
y_trial_times_3mm = np.array(trial_times_3mm)
y_trial_errors_1mm = np.array(trial_errors_1mm)
y_trial_errors_3mm = np.array(trial_errors_3mm)

# Create a figure with two subplots
fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 4))
fig.suptitle("Younger Participants", fontsize=15)

# Plot the first subplot
axs[0].bar(x-0.2, y_trial_times_1mm, width=0.4,
           color='black', align='center', label='1mm')
axs[0].bar(x+0.2, y_trial_times_3mm, width=0.4,
           color='grey', align='center', label='3mm')
axs[0].set_title('Average time per trial')
axs[0].set_xlabel('Button sizes')
axs[0].xaxis.set_label_coords(.5, -.1)
axs[0].set_ylabel('Task Completion Time (Seconds)')
axs[0].set_xticks(x)
axs[0].set_ylim(0, 3.7)
axs[0].set_xticklabels(['5mm', '8mm', '12mm', '5mm',
                       '8mm', '12mm', '5mm',
                        '8mm', '12mm'])
axs[0].text(0.2, -0.07, 'Trial 1', transform=axs[0].transAxes, ha='center')
axs[0].text(.5, -0.07, 'Trial 2', transform=axs[0].transAxes, ha='center')
axs[0].text(.8, -0.07, 'Trial 3', transform=axs[0].transAxes, ha='center')
axs[0].axvline(3.5, 0, 1, color='k')
axs[0].axvline(6.5, 0, 1, color='k')
axs[0].legend(title="Button Spacing")
for i, v in enumerate(y_trial_times_1mm):
    axs[0].text(i+.58, v*1.01,
                str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)
for i, v in enumerate(y_trial_times_3mm):
    axs[0].text(i+.98, v*1.01,
                str("{:.2f}".format(v)), color='red', fontweight='bold', fontsize=7)

# Plot the second subplot
axs[1].bar(x-0.2, y_trial_errors_1mm, width=0.4,
           color='black', align='center', label='1mm')
axs[1].bar(x+0.2, y_trial_errors_3mm, width=0.4,
           color='grey', align='center', label='3mm')
axs[1].set_title('Average Errors per trial')
axs[1].set_xlabel('Button Size')
axs[1].xaxis.set_label_coords(.5, -.1)
axs[1].set_ylabel('Number of Errors')
axs[1].set_xticks(x)
axs[1].set_ylim(0, 2)
axs[1].set_xticklabels(['5mm', '8mm', '12mm', '5mm',
                       '8mm', '12mm', '5mm', '8mm', '12mm'])
axs[1].text(0.2, -0.07, 'Trial 1', transform=axs[1].transAxes, ha='center')
axs[1].text(.5, -0.07, 'Trial 2', transform=axs[1].transAxes, ha='center')
axs[1].text(.8, -0.07, 'Trial 3', transform=axs[1].transAxes, ha='center')
axs[1].axvline(3.5, 0, 1, color='k')
axs[1].axvline(6.5, 0, 1, color='k')
axs[1].legend(title="Button Spacing")
for i, v in enumerate(y_trial_errors_1mm):
    axs[1].text(i+.58, v*1.01,
                str("{:.2f}".format(v)), color='blue', fontweight='bold', fontsize=7)
for i, v in enumerate(y_trial_errors_3mm):
    axs[1].text(i+.98, v*1.01,
                str("{:.2f}".format(v)), color='red', fontweight='bold', fontsize=7)

# Adjust spacing between subplots
fig.tight_layout()


# Show the figure
plt.show()
