import matplotlib.pyplot as plt
import numpy as np
import json
f = open('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\AllOlderAdults.json')
data = json.load(f)


TITLE_SIZE = 20
LABEL_SIZE = 15

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

print('1mm')
for index in range(0, 3):
    print('Time: ', avg_time_per_layout[index])
    print('Errors: ', errors_per_layout[index])

print('3mm')
for index in range(3, 6):
    print('Time: ', avg_time_per_layout[index])
    print('Errors: ', errors_per_layout[index])

fig, axs = plt.subplots(nrows=1, ncols=2, figsize=(8, 6))
fig.suptitle('Experiment Results: Older Adults 2023 (Black) Versus Older Adults 2013 (Red)', fontsize=20)


# Lablelling axis
axs[0].set_title(
    'Task Completion Time', fontsize = LABEL_SIZE)
axs[0].set_xlabel('Button size (mm)', fontsize = LABEL_SIZE)
axs[0].set_ylabel('Task completion time (seconds)', fontsize = LABEL_SIZE)

# Adding 1mm spacing layouts (mine)
ypoints = np.array(avg_time_per_layout[0:3])
xpoints = np.array([5, 8, 12])
axs[0].set_xticks([5, 8, 12])
axs[0].tick_params(axis='x', labelsize=14)
axs[0].tick_params(axis='y', labelsize=14)
axs[0].plot(xpoints, ypoints, color='black',
            label="1mm", linestyle='dashed',  marker='o')

# Adding 5mm spacing layouts (mine)
ypoints = np.array(avg_time_per_layout[3:7])
xpoints = np.array([5, 8, 12])
axs[0].plot(xpoints, ypoints, label="3mm", color='black', marker='s')

# Adding 1mm spacing layouts (Hwangbo et al.)
ypoints = np.array([40.811/8, 17.543/8, 12.206/8])
xpoints = np.array([5, 8, 12])
axs[0].plot(xpoints, ypoints, label="1mm", color='red', linestyle='dashed', marker='o')

# Adding 5mm spacing layouts (Hwangbo et al.)
ypoints = np.array([30.969/8, 14.214/8, 12.266/8])
xpoints = np.array([5, 8, 12])
axs[0].plot(xpoints, ypoints, label="3mm", color='red', marker='s')

# Plot
axs[0].legend(loc="upper right", title="Button Spacing")

axs[1].set_title('Errors Made', fontsize = LABEL_SIZE)
axs[1].set_xlabel('Button size (mm)', fontsize = LABEL_SIZE)
axs[1].set_ylabel('Number of Errors', fontsize = LABEL_SIZE)

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
ypoints = np.array([22.39/8, 3.35/8, 0.24/8])
xpoints = np.array([5, 8, 12])
axs[1].tick_params(axis='x', labelsize=14)
axs[1].tick_params(axis='y', labelsize=14)
axs[1].plot(xpoints, ypoints, label="1mm", color='red', linestyle='dashed', marker='o')

# Adding 5mm spacing layouts (Hwangbo et al.)
ypoints = np.array([18.68/8, 1.56/8, 0.39/8])
xpoints = np.array([5, 8, 12])
axs[1].plot(xpoints, ypoints, label="3mm", color='red', marker='s')

axs[1].legend(loc="upper right", title="Button Spacing")

plt.show()
