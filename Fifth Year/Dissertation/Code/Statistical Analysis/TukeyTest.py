import json
import pandas as pd
import numpy as np
from statsmodels.stats.multicomp import pairwise_tukeyhsd

NUM_OLDER_PART = 12
NUM_YOUNGER_PART = 13

with open("AllOlderAdultsOut.json", "r") as f:
    data_older = json.load(f)

with open("AllYoungerDataOut.json", "r") as g:
    data_younger = json.load(g)

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


def perform_tukey(data, type, repeats):
    test_data = data[0] + data[1] + data[2] + data[3] + data[4] + data[5]
    df = pd.DataFrame({type: test_data,
                    'layout': np.repeat(['Layout 1', 'Layout 2', 'Layout 3', 'Layout 4', 'Layout 5', 'Layout 6'], repeats=repeats)})
    tukey = pairwise_tukeyhsd(endog=df[type],
                            groups=df['layout'],
                            alpha=0.05)
    print(tukey)

print("Older Adults Time: ")
perform_tukey(layout_times_older, "Time", NUM_OLDER_PART*3)
print("Older Adults Errors: ")
perform_tukey(layout_errors_older, "Errors", NUM_OLDER_PART*3)
print("Younger Adults Time: ")
perform_tukey(layout_times_younger, "Time", NUM_YOUNGER_PART*3)
print("Younger Adults Errors: ")
perform_tukey(layout_errors_younger, "Errors", NUM_YOUNGER_PART*3)