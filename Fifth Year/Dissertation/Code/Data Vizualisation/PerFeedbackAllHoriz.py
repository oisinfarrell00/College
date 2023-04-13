import json
import matplotlib.pyplot as plt
import numpy as np
import json

TITLE_SIZE = 20
LABEL_SIZE = 15

with open("AllOlderAdults.json", "r") as f:
    data_older = json.load(f)

with open("AllYoungerData.json", "r") as g:
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


def normalize_list(lst):
    return [item/sum(lst) for item in lst]

# Create sample data
barHeight = .5
br1 = np.arange(1, 2, 3)
br2 = [x + barHeight for x in br1]
br3 = [x + barHeight for x in br2]

y = []
for i in range(0, 4):
    y.append(sum(feedback_times_older[i])/(3*15*1000))
y_feedback_times_older = np.array(normalize_list(y))

y = []
for i in range(0, 4):
    y.append(sum(feedback_errors_older[i])/(3*15))
y_feedback_errors_older = np.array(normalize_list(y))

y = []
for i in range(0, 4):
    y.append(sum(feedback_times_younger[i])/(3*15*1000))
y_feedback_times_younger = np.array(normalize_list(y))

y = []
for i in range(0, 4):
    y.append(sum(feedback_errors_younger[i])/(3*15))
y_feedback_errors_younger = np.array(normalize_list(y))


y_feedback_times_comp = np.array(normalize_list([3.87125, 3.3725, 4.1575, 3]))
y_feedback_errors_comp = np.array(normalize_list([2.335, 1.4475, 2.19, 1.20125]))

none = [y_feedback_times_comp[0], y_feedback_times_older[0], y_feedback_times_younger[0]]
audio = [y_feedback_times_comp[1], y_feedback_times_older[1], y_feedback_times_younger[1]]
tactile = [y_feedback_times_comp[2], y_feedback_times_older[2], y_feedback_times_younger[2]]
audiotactile = [y_feedback_times_comp[3], y_feedback_times_older[3], y_feedback_times_younger[3]]

none_errors = [y_feedback_errors_comp[0], y_feedback_errors_older[0], y_feedback_errors_younger[0]]
audio_errors = [y_feedback_errors_comp[1], y_feedback_errors_older[1], y_feedback_errors_younger[1]]
tactile_errors = [y_feedback_errors_comp[2], y_feedback_errors_older[2], y_feedback_errors_younger[2]]
audiotactile_errors = [y_feedback_errors_comp[3], y_feedback_errors_older[3], y_feedback_errors_younger[3]]

# Create a figure with two subplots
fig, axs = plt.subplots(nrows=2, ncols=1, figsize=(1, 4))
plt.gcf().set_size_inches(15, 10)

cohorts = ['Older Adults (2013)', 'Older Adults(2023)', 'Younger Adults (2023)']
y_pos = np.arange(1, len(cohorts)+1)

# Plot the first subplot
axs[0].barh(y_pos, none, height=barHeight,
           color='black', align='center', label="No Feedback")
axs[0].barh(y_pos, audio, height=barHeight, left=none,
           color='blue', align='center', label="Audio")
axs[0].barh(y_pos, tactile, height=barHeight, left=[i+j for i,j in zip(none, audio)],
           color='red', align='center', label="Tactile")
axs[0].barh(y_pos, audiotactile, height=barHeight, left=[i+j+k for i,j,k in zip(none, audio, tactile)],
           color='grey', align='center', label="Audiotactile")

axs[0].set_title('Portion of Completion time by Feedback Type', fontsize = TITLE_SIZE)
axs[0].set_ylabel('Cohort', fontsize = LABEL_SIZE)
axs[0].set_yticks([1, 2, 3])
axs[0].xaxis.set_label_coords(.5, -.1)
axs[0].set_yticklabels(cohorts)
for tick in axs[0].yaxis.get_major_ticks():
                tick.label.set_fontsize(10) 
for tick in axs[0].xaxis.get_major_ticks():
                tick.label.set_fontsize(10)

axs[0].legend(prop={'size': 12})


# Plot the second subplot
axs[1].barh(y_pos, none_errors, height=barHeight,
           color='black', align='center', label="No Feedback")
axs[1].barh(y_pos, audio_errors, height=barHeight, left=none_errors,
           color='blue', align='center', label="Audio")
axs[1].barh(y_pos, tactile_errors, height=barHeight, left=[i+j for i,j in zip(none_errors, audio_errors)],
           color='red', align='center', label="Tactile")
axs[1].barh(y_pos, audiotactile_errors, height=barHeight, left=[i+j+k for i,j,k in zip(none_errors, audio_errors, tactile_errors)],
           color='grey', align='center', label="Audiotactile")

axs[1].set_title('Portion of Errors by Feedback Type', fontsize = TITLE_SIZE)
axs[1].set_ylabel('Cohort', fontsize = LABEL_SIZE)
axs[1].set_yticks([1, 2, 3])
axs[1].xaxis.set_label_coords(.5, -.1)
axs[1].set_yticklabels(cohorts)
for tick in axs[1].yaxis.get_major_ticks():
                tick.label.set_fontsize(10) 
for tick in axs[1].xaxis.get_major_ticks():
                tick.label.set_fontsize(10)

axs[1].legend(prop={'size': 12})


# Adjust spacing between subplots
fig.tight_layout()

# Show the figure
plt.show()


