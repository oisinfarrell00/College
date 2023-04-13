import matplotlib.pyplot as plt
import numpy as np
import json
NUM_OLDER = 12
NUM_YOUNGER = 13
f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdults.json')
data = json.load(f)
f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdultsOut.json')
data_new = json.load(f)
f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerData.json')
g = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllYoungerDataOut.json')
data_young = json.load(f)
data_young_new = json.load(g)


def returnDataEntry(data, participant, task, layout, feedbackType, trial):
    return data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'Feedback '+str(feedbackType)]['Trial '+str(trial)]


avg_time_per_layout = [0]*6
avg_time_per_layout_young = [0]*6
for participant in range(1, 16):
    for layout in range(1, 7):
        times = []
        times_young = []
        for trial in range(1, 4):
            times.append(int(returnDataEntry(data, participant,
                                             1, layout, 1, trial)['Time']))
            times_young.append(int(returnDataEntry(data_young, participant,
                                                   1, layout, 1, trial)['Time']))
        avg_time_per_layout[layout -
                            1] = avg_time_per_layout[layout-1] + sum(times)/(1000*15*3)
        avg_time_per_layout_young[layout -
                                  1] = avg_time_per_layout_young[layout-1] + sum(times_young)/(1000*15*3)

errors_per_layout = [0]*6
errors_per_layout_young = [0]*6
for participant in range(1, 16):
    for layout in range(1, 7):
        errors = []
        errors_young = []
        for trial in range(1, 4):
            errors.append(int(returnDataEntry(data, participant,
                                              1, layout, 1, trial)['Errors']))
            errors_young.append(int(returnDataEntry(data_young, participant,
                                                    1, layout, 1, trial)['Errors']))
        errors_per_layout[layout -
                          1] = errors_per_layout[layout-1] + sum(errors)/(15*3)
        errors_per_layout_young[layout -
                                1] = errors_per_layout_young[layout-1] + sum(errors_young)/(15*3)
        
avg_time_per_layout_new = [0]*6
errors_per_layout_new = [0]*6     
for participant in range(1, NUM_OLDER+1):
    for layout in range(1, 7):
        times = []
        errors = []
        for trial in range(1, 4):
            times.append(int(returnDataEntry(data_new, participant,
                                             1, layout, 1, trial)['Time']))
            errors.append(int(returnDataEntry(data_new, participant,
                                              1, layout, 1, trial)['Errors']))
        errors_per_layout_new[layout -
                          1] = errors_per_layout_new[layout-1] + sum(errors)/(15*3)
        avg_time_per_layout_new[layout -
                            1] = avg_time_per_layout_new[layout-1] + sum(times)/(1000*15*3)
        
avg_time_per_layout_young_new = [0]*6
errors_per_layout_young_new = [0]*6     
for participant in range(1, NUM_YOUNGER+1):
    for layout in range(1, 7):
        times = []
        errors = []
        for trial in range(1, 4):
            times.append(int(returnDataEntry(data_young_new, participant,
                                             1, layout, 1, trial)['Time']))
            errors.append(int(returnDataEntry(data_young_new, participant,
                                              1, layout, 1, trial)['Errors']))
        errors_per_layout_young_new[layout -
                          1] = errors_per_layout_young_new[layout-1] + sum(errors)/(15*3)
        avg_time_per_layout_young_new[layout -
                            1] = avg_time_per_layout_young_new[layout-1] + sum(times)/(1000*15*3)


for i in range(0, 6):
    print(errors_per_layout_young_new[i])
    # print("Older Adults")
    # print('Layout ', str(i+1), " prev time: ",  avg_time_per_layout[i], " updated time: ",  avg_time_per_layout_new[i])
    # print("Older Adults")
    # print('Layout ', str(i+1), " prev errors: ",  errors_per_layout[i], " updated errors: ",  errors_per_layout_new[i])
    # print("Younger Adults")
    # print('Layout ', str(i+1), " prev time: ",  avg_time_per_layout_young[i], " updated time: ",  avg_time_per_layout_young_new[i])
    # print("Younger Adults")
    # print('Layout ', str(i+1), " prev errors: ",  errors_per_layout_young[i], " updated errors: ",  errors_per_layout_young_new[i])



# fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 6))
# fig.suptitle('Older Adults & Younger Adults 2013 with outliers (Black) vs without (Blue)', fontsize = 20)


# # Lablelling axis
# axs[0].set_title(
#     'Task completion time', fontsize=12)
# axs[0].set_xlabel('Button size (mm)', fontsize=15)
# axs[0].set_ylabel('Task completion time seconds', fontsize=15)

# # Adding 1mm spacing layouts (mine)
# ypoints = np.array(avg_time_per_layout[0:3])
# xpoints = np.array([5, 8, 12])
# axs[0].set_xticks([5, 8, 12])
# axs[0].plot(xpoints, ypoints, color='black',
#             label="1mm", linestyle='dashed',  marker='o')

# # Adding 5mm spacing layouts (mine)
# ypoints = np.array(avg_time_per_layout[3:7])
# xpoints = np.array([5, 8, 12])
# axs[0].plot(xpoints, ypoints, label="3mm", color='black', marker='s')

# # Adding 1mm spacing layouts (mine)
# ypoints = np.array(avg_time_per_layout_new[0:3])
# xpoints = np.array([5, 8, 12])
# axs[0].set_xticks([5, 8, 12])
# axs[0].plot(xpoints, ypoints, color='blue',
#             label="1mm", linestyle='dashed',  marker='o')

# # Adding 5mm spacing layouts (mine)
# ypoints = np.array(avg_time_per_layout_new[3:7])
# xpoints = np.array([5, 8, 12])
# axs[0].plot(xpoints, ypoints, label="3mm", color='blue', marker='s')

# # Adding 1mm spacing layouts (mine)
# ypoints = np.array(avg_time_per_layout_young_new[0:3])
# xpoints = np.array([5, 8, 12])
# axs[0].set_xticks([5, 8, 12])
# axs[0].plot(xpoints, ypoints, color='blue',
#             label="1mm", linestyle='dashed',  marker='o')

# # Adding 5mm spacing layouts (mine)
# ypoints = np.array(avg_time_per_layout_young_new[3:7])
# xpoints = np.array([5, 8, 12])
# axs[0].plot(xpoints, ypoints, label="3mm", color='blue', marker='s')

# # Adding 1mm spacing layouts (Hwangbo et al.)
# ypoints = np.array(avg_time_per_layout_young[0:3])
# xpoints = np.array([5, 8, 12])
# axs[0].set_xticks([5, 8, 12])
# axs[0].plot(xpoints, ypoints, label="1mm", color='black', marker='o')

# # Adding 5mm spacing layouts (Hwangbo et al.)
# ypoints = np.array(avg_time_per_layout_young[3:7])
# xpoints = np.array([5, 8, 12])
# axs[0].set_xticks([5, 8, 12])
# axs[0].plot(xpoints, ypoints, label="3mm", color='black', marker='s')

# # Plot
# axs[0].legend(loc="upper right", title="Button Spacing")

# axs[1].set_title('Number of Errors')
# axs[1].set_xlabel('Button size (mm)')
# axs[1].set_ylabel('Number of Errors')

# # Adding 1mm spacing layouts (mine)
# ypoints = np.array(errors_per_layout[0:3])
# xpoints = np.array([5, 8, 12])
# axs[1].set_xticks([5, 8, 12])
# axs[1].plot(xpoints, ypoints, color='black',
#             label="1mm", linestyle='dashed',  marker='o')

# # Adding 5mm spacing layouts (mine)
# ypoints = np.array(errors_per_layout[3:7])
# xpoints = np.array([5, 8, 12])
# axs[1].plot(xpoints, ypoints, label="3mm", color='black', marker='s')

# # Adding 1mm spacing layouts (mine)
# ypoints = np.array(errors_per_layout_new[0:3])
# xpoints = np.array([5, 8, 12])
# axs[1].set_xticks([5, 8, 12])
# axs[1].plot(xpoints, ypoints, color='blue',
#             label="1mm", linestyle='dashed',  marker='o')

# # Adding 5mm spacing layouts (mine)
# ypoints = np.array(errors_per_layout_new[3:7])
# xpoints = np.array([5, 8, 12])
# axs[1].plot(xpoints, ypoints, label="3mm", color='blue', marker='s')

# # Adding 1mm spacing layouts (Hwangbo et al.)
# ypoints = np.array(errors_per_layout_young[0:3])
# xpoints = np.array([5, 8, 12])
# axs[1].set_xticks([5, 8, 12])
# axs[1].plot(xpoints, ypoints, label="1mm", color='black', marker='o')

# # Adding 5mm spacing layouts (Hwangbo et al.)
# ypoints = np.array(errors_per_layout_young[3:7])
# xpoints = np.array([5, 8, 12])
# axs[1].set_xticks([5, 8, 12])
# axs[1].plot(xpoints, ypoints, label="3mm", color='black', marker='s')

# # Adding 1mm spacing layouts (Hwangbo et al.)
# ypoints = np.array(errors_per_layout_young_new[0:3])
# xpoints = np.array([5, 8, 12])
# axs[1].set_xticks([5, 8, 12])
# axs[1].plot(xpoints, ypoints, label="1mm", color='blue', marker='o')

# # Adding 5mm spacing layouts (Hwangbo et al.)
# ypoints = np.array(errors_per_layout_young_new[3:7])
# xpoints = np.array([5, 8, 12])
# axs[1].set_xticks([5, 8, 12])
# axs[1].plot(xpoints, ypoints, label="3mm", color='blue', marker='s')


# axs[1].legend(loc="upper right", title='Button Spacing')

# plt.show()
