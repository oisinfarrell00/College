import matplotlib.pyplot as plt
import numpy as np
import json
f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdults.json')
data = json.load(f)


def returnDataEntry(data, participant, task, layout, feedbackType, trial):
    return data['Participant '+str(participant)]['Task '+str(task)]['Layout '+str(layout) if layout != -1 else 'Feedback '+str(feedbackType)]['Trial '+str(trial)]


avg_time_per_layout = [0]*6
for participant in range(1, 16):
    for layout in range(1, 7):
        times = []
        for trial in range(1, 4):
            times.append(int(returnDataEntry(data, participant,
                                             1, layout, 1, trial)['Time']))
        avg_time_per_layout[layout -
                            1] = avg_time_per_layout[layout-1] + sum(times)/(1000*15*3)

errors_per_layout = [0]*6
for participant in range(1, 16):
    for layout in range(1, 7):
        errors = []
        for trial in range(1, 4):
            errors.append(int(returnDataEntry(data, participant,
                                              1, layout, 1, trial)['Errors']))
        errors_per_layout[layout -
                          1] = errors_per_layout[layout-1] + sum(errors)/(15*3)

for index in range(1, 7):
    print('Layout '+str(index)+' Time: ' + str(avg_time_per_layout[index-1]))
    print('Layout '+str(index)+' Errors: ' + str(errors_per_layout[index-1]))


fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 6))


# Lablelling axis
axs[0].set_title(
    'Task completion time Older adults 2013 (Red) versus 2023 (Black)')
axs[0].set_xlabel('Button size (MM)')
axs[0].set_ylabel('Task completion time seconds')

# Adding 1mm spacing layouts (mine)
ypoints = np.array(avg_time_per_layout[0:3])
xpoints = np.array([5, 8, 12])
axs[0].set_xticks([5, 8, 12])
axs[0].plot(xpoints, ypoints, color='black',
            label="1mm", linestyle='dashed',  marker='o')

# Adding 5mm spacing layouts (mine)
ypoints = np.array(avg_time_per_layout[3:7])
xpoints = np.array([5, 8, 12])
axs[0].plot(xpoints, ypoints, label="3mm", color='black', marker='s')

# Adding 1mm spacing layouts (Hwangbo et al.)
ypoints = np.array([1.7, 0.731, 0.509])
xpoints = np.array([5, 8, 12])
axs[0].plot(xpoints, ypoints, label="1mm", color='red', marker='o')

# Adding 5mm spacing layouts (Hwangbo et al.)
ypoints = np.array([1.290375, 0.59225, 0.511])
xpoints = np.array([5, 8, 12])
axs[0].plot(xpoints, ypoints, label="3mm", color='red', marker='s')

# Plot
axs[0].legend(loc="upper right")

axs[1].set_title('Errors: Older adults 2013 (Red) versus 2013 (Black)')
axs[1].set_xlabel('Button size (MM)')
axs[1].set_ylabel('Task completion time seconds')

# Adding 1mm spacing layouts (mine)
ypoints = np.array(errors_per_layout[0:3])
xpoints = np.array([5, 8, 12])
axs[1].set_xticks([5, 8, 12])
axs[1].plot(xpoints, ypoints, color='black',
            label="1mm", linestyle='dashed',  marker='o')

# Adding 5mm spacing layouts (mine)
ypoints = np.array(errors_per_layout[3:7])
xpoints = np.array([5, 8, 12])
axs[1].plot(xpoints, ypoints, label="3mm", color='black', marker='s')

# Adding 1mm spacing layouts (Hwangbo et al.)
ypoints = np.array([22.39/24, 3.35/24, 0.24/24])
xpoints = np.array([5, 8, 12])
axs[1].plot(xpoints, ypoints, label="1mm", color='red', marker='o')

# Adding 5mm spacing layouts (Hwangbo et al.)
ypoints = np.array([18.68/24, 1.56/24, 0.39/24])
xpoints = np.array([5, 8, 12])
axs[1].plot(xpoints, ypoints, label="3mm", color='red', marker='s')

axs[1].legend(loc="upper right")

plt.show()
