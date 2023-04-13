from scipy.stats import f_oneway
import json
import pandas as pd
import numpy as np
from statsmodels.stats.multicomp import pairwise_tukeyhsd

f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdults.json')
data_older = json.load(f)

f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerData.json')
data_younger = json.load(f)

def get_data_entry(data, participant, task, layout, feedbackType, trial, type):
    return int(data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'FeedbackType '+str(feedbackType)]['Trial '+str(trial)][type])

layout_time = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
layout_errors = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
layout_time_younger = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
layout_errors_younger = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
for participant in range(1, 16):
    for layout in range(1, 7):
        for trial in range(1, 4):
            index = ((layout-1)*3)+(trial-1)
            layout_time[index].append(int(get_data_entry(data_older, participant,
                                                                                                1, layout, -1, trial,'Time')))
            layout_errors[index].append(int(get_data_entry(data_older, participant,
                                                                                                    1, layout, -1, trial, 'Errors')))
            layout_time_younger[index].append(int(get_data_entry(data_younger, participant,
                                                                                                1, layout, -1, trial, 'Time')))
            layout_errors_younger[index].append(int(get_data_entry(data_younger, participant,
                                                                                                    1, layout, -1, trial, 'Errors')))
            

def performAnalysis(data):
    for layout in range(1, 7):
        f, p_value = f_oneway(data[(layout-1)*3], data[((layout-1)*3)+1], data[((layout-1)*3)+2])
        print("Layout ", str(layout), ": ", "SIGNIFICANT over three trials" if p_value < 0.05 else "NOT significant over three trials", " p="+str(p_value))


print("Older Adults (TIME): ")
performAnalysis(layout_time)
print("Older Adults (ERORS): ")
performAnalysis(layout_errors)
print("Younger Adults (TIME): ")
performAnalysis(layout_time_younger)
print("Younger Adults (ERRORS): ")
performAnalysis(layout_errors_younger)

def perform_tukey(data, layout):
    test_data = data[(layout-1)*3] + data[((layout-1)*3)+1] + data[((layout-1)*3)+2]
    print(len(data[(layout-1)*3]), "|", len(data[((layout-1)*3)+1]), "|", len(data[((layout-1)*3)+2]))
    df = pd.DataFrame({'Trial': test_data,
                    'layout': np.repeat(['Trial 1', 'Trial 2', 'Trial 3'], repeats=15)})
    tukey = pairwise_tukeyhsd(endog=df['Trial'],
                            groups=df['layout'],
                            alpha=0.05)
    print(tukey)

perform_tukey(layout_time_younger, 1)