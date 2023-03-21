import json


def parse_trials(data, layout_index, idnetifier):
    layout_string = idnetifier + " " + str(layout_index)
    layout = {
        layout_string: {}
    }
    for i in range(1, 4):
        trial_index = i
        next_trial_index = trial_index + 1
        next_trial = "Trial " + str(next_trial_index)
        start_trial = "Trial " + str(trial_index)
        start = data.index(start_trial)
        end = 0
        if next_trial in data:
            end = data.index(next_trial)
        else:
            end = len(data)

        trial_info = data[start+1:end]
        trial_data = {
            start_trial: {
                "Errors": trial_info[1],
                "Position": trial_info[3],
                "Time": trial_info[5]
            }
        }
        layout[layout_string].update(trial_data)
    return layout


def parse_task_1(task_1_data):
    task_one = {
        "Task 1": {

        }
    }
    for i in range(1, 7):
        layout_index = i
        next_layout_index = layout_index + 1
        next_layout = "Layout "+str(next_layout_index)
        start_layout = "Layout "+str(layout_index)
        start = task_1_data.index(start_layout)
        end = 0
        if next_layout in task_1_data:
            end = task_1_data.index(next_layout)
        else:
            end = len(task_1_data)

        layout_data = task_1_data[start+1:end]
        task_one["Task 1"].update(parse_trials(
            layout_data, layout_index, "Layout"))
    return task_one


def parse_task_2(task_1_data):
    task_two = {
        "Task 2": {

        }
    }
    for i in range(1, 5):
        feedback_type_index = i
        next_feedback_type_index = feedback_type_index + 1
        next_feedback_type = "FeedbackType "+str(next_feedback_type_index)
        start_feedback_type = "FeedbackType "+str(feedback_type_index)
        start = task_1_data.index(start_feedback_type)
        end = 0
        if next_feedback_type in task_1_data:
            end = task_1_data.index(next_feedback_type)
        else:
            end = len(task_1_data)

        feedback_type_data = task_1_data[start+1:end]
        task_two["Task 2"].update(parse_trials(
            feedback_type_data, feedback_type_index, "FeedbackType"))
    return task_two


def parse_participant(part_data, participant_index):
    participant_string = "Participant " + str(participant_index)
    participant_data = {
        participant_string: {

        }
    }
    task_1_start = 0
    task_1_end = part_data.index("Task 2")
    task_1_data = part_data[task_1_start+1:task_1_end]
    participant_data[participant_string].update(parse_task_1(task_1_data))
    task_2_start = part_data.index("Task 2")
    task_2_end = len(part_data)
    task_2_data = part_data[task_2_start+1:task_2_end+1]
    participant_data[participant_string].update(parse_task_2(task_2_data))
    return participant_data


def parse_data(data, num_participants):
    experiment_data = {

    }

    for i in range(1, num_participants+1):
        participant_index = i
        next_part_index = participant_index + 1
        next_part = "Participant "+str(next_part_index)
        start_part = "Participant "+str(participant_index)
        start = data.index(start_part)
        end = 0
        if next_part in data:
            end = data.index(next_part)
        else:
            end = len(data)

        participant_data = data[start+1:end]
        experiment_data.update(parse_participant(
            participant_data, participant_index))
    return experiment_data


def writeToJSONFile(json_to_file, filename):
    json_object = json.dumps(json_to_file, indent=4)
    with open(filename, "w") as outfile:
        outfile.write(json_object)


with open('ExpDataYoung.txt') as f:
    lines = []
    num_participants = 0
    while True:
        line = f.readline()
        if not line:
            break
        if "Participant" in line:
            num_participants = num_participants + 1
        lines.append(line.strip("\n"))

writeToJSONFile(parse_data(lines, num_participants), "AllYoungerData.json")
