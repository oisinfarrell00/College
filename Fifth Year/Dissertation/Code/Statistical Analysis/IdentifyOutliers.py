import json
import numpy as np

NUM_PART = 16

f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerData.json')
data_older = json.load(f)

f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerData.json')
data_younger = json.load(f)

def get_data_entry(data, participant, task, layout, feedbackType, trial, type):
    return int(data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'FeedbackType '+str(feedbackType)]['Trial '+str(trial)][type])

layout_time = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
layout_errors = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
layout_time_younger = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
layout_errors_younger = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]

for participant in range(1, NUM_PART):
    for layout in range(1, 7):
        for trial in range(1, 4):
            index = ((layout-1)*3)+(trial-1)
            layout_time[index].append(get_data_entry(data_older, participant,
                                                                                                1, layout, -1, trial,'Time'))
            layout_errors[index].append(get_data_entry(data_older, participant,
                                                                                                    1, layout, -1, trial, 'Errors'))
            layout_time_younger[index].append(get_data_entry(data_younger, participant,
                                                                                                1, layout, -1, trial, 'Time'))
            layout_errors_younger[index].append(get_data_entry(data_younger, participant,
                                                                                                    1, layout, -1, trial, 'Errors'))
            
feedback_time = [[], [], [], [], [], [], [], [], [], [], [], []]
feedback_errors = [[], [], [], [], [], [], [], [], [], [], [], []]
feedback_time_younger = [[], [], [], [], [], [], [], [], [], [], [], []]
feedback_errors_younger = [[], [], [], [], [], [], [], [], [], [], [], []]

for participant in range(1, NUM_PART):
    for feedback in range(1, 5):
        for trial in range(1, 4):
            index = ((feedback-1)*3)+(trial-1)
            feedback_time[index].append(get_data_entry(data_older, participant,
                                                                                                2, -1, feedback, trial,'Time'))
            feedback_errors[index].append(get_data_entry(data_older, participant,
                                                                                                    2, -1, feedback, trial, 'Errors'))
            feedback_time_younger[index].append(get_data_entry(data_younger, participant,
                                                                                                2, -1, feedback, trial, 'Time'))
            feedback_errors_younger[index].append(get_data_entry(data_younger, participant,
                                                                                                    2, -1, feedback, trial, 'Errors'))

def is_outlier_z_score(lst, val, threshold=3):
    if len(lst) == 0:
        return False

    median = np.median(lst)
    diff = np.abs(lst - median)
    mad = np.median(diff)

    if mad == 0:
        return False

    return np.abs((val - median) / mad) > threshold


older_participant_scores = [0]*15
for participant in range(1, NUM_PART):
    for layout in range(1, 7):
        for trial in range(1, 4):
            list_index = ((layout-1)*3)+(trial-1)
            val = get_data_entry(data_older, participant, 1, layout, -1, trial,'Time')
            if(is_outlier_z_score(layout_time[list_index], val)): 
                print('Participant: ', participant, ' layout: ', layout, ' Trial: ', trial)
                older_participant_scores[participant-1]=older_participant_scores[participant-1]+1

            val = get_data_entry(data_older, participant, 1, layout, -1, trial,'Errors')
            if(is_outlier_z_score(layout_errors[list_index], val)): 
                #print(participant)
                older_participant_scores[participant-1]=older_participant_scores[participant-1]+1
            

for participant in range(1, NUM_PART):
    for feedback in range(1, 5):
        for trial in range(1, 4):
            list_index = ((feedback-1)*3)+(trial-1)
            val = get_data_entry(data_older, participant, 2, -1, feedback, trial,'Time')
            if(is_outlier_z_score(feedback_time[list_index], val)): older_participant_scores[participant-1]=older_participant_scores[participant-1]+1
            val = get_data_entry(data_older, participant, 2, -1, feedback, trial,'Errors')
            if(is_outlier_z_score(feedback_errors[list_index], val)): older_participant_scores[participant-1]=older_participant_scores[participant-1]+1

            
for participant_score in older_participant_scores:
    print(participant_score)



