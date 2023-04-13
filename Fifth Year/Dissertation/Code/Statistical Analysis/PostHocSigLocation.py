from scipy.stats import f_oneway
import numpy as np
import json
from statsmodels.stats.multicomp import pairwise_tukeyhsd
import pandas as pd

f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdults.json')
data_older = json.load(f)

f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerData.json')
data_younger = json.load(f)

def get_data_entry(data, participant, task, layout, feedbackType, trial, type):
    return int(data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'FeedbackType '+str(feedbackType)]['Trial '+str(trial)][type])

location_time = [[], [], [], [], [], [], [], []]
location_errors = [[], [], [], [], [], [], [], []]
location_time_younger = [[], [], [], [], [], [], [], []]
location_errors_younger = [[], [], [], [], [], [], [], []]
for participant in range(1, 16):
    for layout in range(1, 7):
        for trial in range(1, 4):
            location_index = get_data_entry(data_older, participant,
                                                  1, layout, -1, trial, 'Position')
            
            location_time[location_index].append(get_data_entry(data_older, participant,
                                                                                                1, layout, -1, trial,'Time')/(1000))
            location_errors[location_index].append(get_data_entry(data_older, participant,
                                                                                                    1, layout, -1, trial,'Errors'))
            location_index = get_data_entry(data_younger, participant,
                                                  1, layout, -1, trial, 'Position')
            location_time_younger[location_index].append(get_data_entry(data_younger, participant,
                                                                                                1, layout, -1, trial, 'Time')/(1000))
            location_errors_younger[location_index].append(get_data_entry(data_younger, participant,
                                                                                                    1, layout, -1, trial, 'Errors'))
            

def perform_anova(data):
    f_statistic, p_value = f_oneway(*data)
    return p_value

def perform_tukey(data):
    tukey_results = pairwise_tukeyhsd(np.concatenate([*data]), np.concatenate([['NW'] * len(data[0]), ['N'] * len(data[1]), ['NE'] * len(data[2]), ['W'] * len(data[3]), ['E'] * len(data[4]), ['Sw'] * len(data[5]), ['S'] * len(data[6]), ['SE'] * len(data[7])]))
    return (tukey_results)

def perform_analysis(data, message):
    p_value = perform_anova(data)
    print(message, " p=", p_value )
    if p_value < 0.05:
        print(perform_tukey(data))

print("Significance of Location")
perform_analysis(location_time, "Older Adults Time:")
perform_analysis(location_errors, "Older Adults Errors:")
perform_analysis(location_time_younger, "Younger Adults Time:")
perform_analysis(location_errors_younger, "Younger Adults Errors:")