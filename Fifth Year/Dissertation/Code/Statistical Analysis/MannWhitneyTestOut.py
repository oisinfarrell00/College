import json
from scipy.stats import stats

NUM_OLDER_PART = 12
NUM_YOUNGER_PART = 13

with open("AllYoungerDataOut.json", "r") as f:
    data_younger = json.load(f)

with open("AllOlderAdultsOut.json", "r") as h:
    data_older = json.load(h)

def get_data_entry(data, participant, task, layout, feedbackType, trial, type):
    return int(data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'FeedbackType '+str(feedbackType)]['Trial '+str(trial)][type])

layout_times_older = [[get_data_entry(data_older, participant, 1, layout, 1, trial, 'Time') for participant in range(1, NUM_OLDER_PART+1) for trial in range(1, 4)] for layout in range(1, 7)]
layout_errors_older = [[get_data_entry(data_older, participant, 1, layout, 1, trial, 'Errors') for participant in range(1, NUM_OLDER_PART+1) for trial in range(1, 4)] for layout in range(1, 7)]
layout_times_younger = [[get_data_entry(data_younger, participant, 1, layout, 1, trial, 'Time') for participant in range(1, NUM_YOUNGER_PART+1) for trial in range(1, 4)] for layout in range(1, 7)]
layout_errors_younger = [[get_data_entry(data_younger, participant, 1, layout, 1, trial, 'Errors') for participant in range(1, NUM_YOUNGER_PART+1) for trial in range(1, 4)] for layout in range(1, 7)]
feedback_times_older = [[get_data_entry(data_older, participant, 2, -1, feedback, trial, 'Time') for participant in range(1, NUM_OLDER_PART+1) for trial in range(1, 4)] for feedback in range(1, 5)]
feedback_errors_older = [[get_data_entry(data_older, participant, 2, -1, feedback, trial, 'Errors') for participant in range(1, NUM_OLDER_PART+1) for trial in range(1, 4)] for feedback in range(1, 5)]
feedback_times_younger = [[get_data_entry(data_younger, participant, 2, -1, feedback, trial, 'Time') for participant in range(1, NUM_YOUNGER_PART+1) for trial in range(1, 4)] for feedback in range(1, 5)]
feedback_errors_younger = [[get_data_entry(data_younger, participant, 2, -1, feedback, trial, 'Errors') for participant in range(1, NUM_YOUNGER_PART+1) for trial in range(1, 4)] for feedback in range(1, 5)]

layout_times = layout_times_older + layout_times_younger
layout_errors = layout_errors_older + layout_errors_younger
feedback_times = feedback_times_older + feedback_times_younger
feedback_errors = feedback_errors_older + feedback_errors_younger

def perform_mann_whitney(data, tag):
    offset = int(len(data)/2)
    for index in range(1, offset+1):
        print(tag, str(index), ': ', stats.mannwhitneyu(data[index-1], data[offset+index-1], alternative='two-sided'))

print("Mann Whitney Layout (Time): ")
perform_mann_whitney(layout_times, "Layout ")
print("Mann Whitney Layout (Errors)")
perform_mann_whitney(layout_errors, "Layout ")
print("Mann Whitney Feedback (Time): ")
perform_mann_whitney(feedback_times, "Feedback ")
print("Mann Whitney Feedback (Errors)")
perform_mann_whitney(feedback_errors, "Feedback ")