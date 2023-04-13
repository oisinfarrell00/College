import json
import matplotlib.pyplot as plt
import numpy as np
import json

TITLE_SIZE = 20
LABEL_SIZE = 15

with open("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdults.json", "r") as f:
    data_older = json.load(f)

with open("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\\AllYoungerData.json", "r") as g:
    data_younger = json.load(g)

feedback_times_older = [[], [], [], []]
feedback_times_younger = [[], [], [], []]
feedback_errors_older = [[], [], [], []]
feedback_errors_younger = [[], [], [], []]

def returnDataEntry(data, participant, task, layout, feedbackType, trial):
    return data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'FeedbackType '+str(feedbackType)]['Trial '+str(trial)]

for participant in range(1, 16):
    for feedback_type in range(1, 5):
        for trial in range(1, 4):
            time = int(returnDataEntry(data_older, participant,
                                             2, -1, feedback_type, trial)['Time'])
            feedback_times_older[feedback_type-1].append(time)
            errors = int(returnDataEntry(data_older, participant,
                                             2, -1, feedback_type, trial)['Errors'])
            feedback_errors_older[feedback_type-1].append(errors)
            time = int(returnDataEntry(data_younger, participant,
                                             2, -1, feedback_type, trial)['Time'])
            feedback_times_younger[feedback_type-1].append(time)
            errors = int(returnDataEntry(data_younger, participant,
                                             2, -1, feedback_type, trial)['Errors'])
            feedback_errors_younger[feedback_type-1].append(errors)



    

# Create sample data
barWidth = 0.25
br1 = np.arange(len(feedback_times_older))
br2 = [x + barWidth for x in br1]
br3 = [x + barWidth for x in br2]

y = []
for i in range(0, 4):
    y.append(sum(feedback_times_older[i])/(3*15*1000))
y_feedback_times_older = np.array(y)

y = []
for i in range(0, 4):
    y.append(sum(feedback_errors_older[i])/(3*15))
y_feedback_errors_older = np.array(y)

y = []
for i in range(0, 4):
    y.append(sum(feedback_times_younger[i])/(3*15*1000))
y_feedback_times_younger = np.array(y)

y = []
for i in range(0, 4):
    y.append(sum(feedback_errors_younger[i])/(3*15))
    print(sum(feedback_errors_younger[i])/(3*15))
y_feedback_errors_younger = np.array(y)


y_feedback_times_comp = np.array([3.87125, 3.3725, 4.1575, 3])
y_feedback_errors_comp = np.array([2.335, 1.4475, 2.19, 1.20125])


# Create a figure with two subplots
fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 4))
fig.suptitle('Task Completion Time and Errors by Feedback Type', fontsize=TITLE_SIZE)

# Plot the first subplot
axs[0].bar(br2, y_feedback_times_older, width=barWidth,
           color='black', align='center', label="Older Participants (2023)")
axs[0].bar(br3, y_feedback_times_younger, width=barWidth,
           color='grey', align='center', label="Younger Participants (2023)")
axs[0].bar(br1, y_feedback_times_comp, width=barWidth,
           color='red', align='center', label="Older Participants (2013)")
axs[0].set_title('Average Task Completion Time', fontsize = TITLE_SIZE)
axs[0].set_ylim([0, 6])
axs[0].set_xlabel('Feeback Type', fontsize = LABEL_SIZE)
axs[0].xaxis.set_label_coords(.5, -.1)
axs[0].set_ylabel('Task Completion Time (Seconds)', fontsize = LABEL_SIZE)
for tick in axs[0].yaxis.get_major_ticks():
                tick.label.set_fontsize(15) 
for tick in axs[0].xaxis.get_major_ticks():
                tick.label.set_fontsize(15)
axs[0].set_xticks([r + barWidth for r in range(len(feedback_times_older))])
axs[0].set_xticklabels(['None', 'Audio', 'Tactile', 'Audiotatile'])
axs[0].legend()
axs[0].legend(prop={'size': 12})


# Plot the second subplot
axs[1].bar(br2, y_feedback_errors_older, width=barWidth,
           color='black', align='center', label="Older Participants (2023)")
axs[1].bar(br3, y_feedback_errors_younger, width=barWidth,
           color='grey', align='center', label="Younger Participants (2023)")
axs[1].bar(br1, y_feedback_errors_comp, width=barWidth,
           color='red', align='center', label="Older Participants (2013)")
axs[1].set_title('Average Number of Errors', fontsize = TITLE_SIZE)
axs[1].set_xlabel('Button Location', fontsize = LABEL_SIZE)
for tick in axs[1].yaxis.get_major_ticks():
                tick.label.set_fontsize(15)
for tick in axs[1].xaxis.get_major_ticks():
                tick.label.set_fontsize(15) 
axs[1].xaxis.set_label_coords(.5, -.1)
axs[1].set_ylim([0, 4])
axs[1].set_ylabel('Number of Errors', fontsize = LABEL_SIZE)
axs[1].set_xticks([r + barWidth for r in range(len(feedback_errors_older))])
axs[1].set_xticklabels(['None', 'Audio', 'Tactile', 'Aduitactile'])
axs[1].legend(prop={'size': 12})


# Adjust spacing between subplots
fig.tight_layout()

# Show the figure
plt.show()


