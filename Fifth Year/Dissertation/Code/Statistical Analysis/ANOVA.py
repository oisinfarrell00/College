import json
from scipy.stats import f_oneway

NUM_OLDER_PART = 12
NUM_YOUNGER_PART = 13

with open("AllOlderAdultsOut.json", "r") as f:
    data_older = json.load(f)

with open("AllYoungerDataOut.json", "r") as g:
    data_younger = json.load(g)

def get_data_entry(data, participant, task, layout, feedbackType, trial, type):
    return int(data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'FeedbackType '+str(feedbackType)]['Trial '+str(trial)][type])

# Reading in data
layout_times_older = [[get_data_entry(data_older, participant, 1, layout, 1, trial, 'Time') for participant in range(1, NUM_OLDER_PART+1) for trial in range(1, 4)] for layout in range(1, 7)]
layout_errors_older = [[get_data_entry(data_older, participant, 1, layout, 1, trial, 'Errors') for participant in range(1, NUM_OLDER_PART+1) for trial in range(1, 4)] for layout in range(1, 7)]
layout_times_younger = [[get_data_entry(data_younger, participant, 1, layout, 1, trial, 'Time') for participant in range(1, NUM_YOUNGER_PART+1) for trial in range(1, 4)] for layout in range(1, 7)]
layout_errors_younger = [[get_data_entry(data_younger, participant, 1, layout, 1, trial, 'Errors') for participant in range(1, NUM_YOUNGER_PART+1) for trial in range(1, 4)] for layout in range(1, 7)]
feedback_times_older = [[get_data_entry(data_older, participant, 2, -1, feedback, trial, 'Time') for participant in range(1, NUM_OLDER_PART+1) for trial in range(1, 4)] for feedback in range(1, 5)]
feedback_errors_older = [[get_data_entry(data_older, participant, 2, -1, feedback, trial, 'Errors') for participant in range(1, NUM_OLDER_PART+1) for trial in range(1, 4)] for feedback in range(1, 5)]
feedback_times_younger = [[get_data_entry(data_younger, participant, 2, -1, feedback, trial, 'Time') for participant in range(1, NUM_YOUNGER_PART+1) for trial in range(1, 4)] for feedback in range(1, 5)]
feedback_errors_younger = [[get_data_entry(data_younger, participant, 2, -1, feedback, trial, 'Errors') for participant in range(1, NUM_YOUNGER_PART+1) for trial in range(1, 4)] for feedback in range(1, 5)]

def perform_anova(data):
    f_statistic, p_value = f_oneway(
        *data)
    if p_value < 0.05:
        return ("Significant p=" + str(p_value))
    else:
        return ("NOT Significant")

print("Layouts: ")
print("Older Adults Time: ", perform_anova(layout_times_older))
print("Older Adults Errors: ", perform_anova(layout_errors_older))
print("Younger Adults Time: ", perform_anova(layout_times_younger))
print("Younger Adults Errors: ", perform_anova(layout_errors_younger))
print("Feedback: ")
print("Older Adults Time: ", perform_anova(feedback_times_older))
print("Older Adults Errors: ", perform_anova(feedback_errors_older))
print("Younger Adults Time: ", perform_anova(feedback_times_younger))
print("Younger Adults Errors: ", perform_anova(feedback_errors_younger))