import copy

# initial state
initialState = [['L', 'C', 'B', 'A'], ['M'], ['R']]

# goal state
goalState = [['L'], ['M'], ['R', 'C', 'B', 'A']]

'''
state is a list of stacks with items 
(x,y) is a tupel which describes the on("A", "B") movement
move x on top of y
'''
def moveBlock(state, x, y):
    # searching in which stack y is (where I want to move x later)
    y_stack = []
    for stack in state:
        if stack[-1] == y:
            y_stack = stack
            break

    # searching where x is
    for stack in state:
        # if element on top is x
        if stack[-1] == x:
            y_stack.append(stack.pop())
            break
    # print("state in the loop")
    # print(initialState)


'''
returns list of action tupels
'''
def get_possible_actions(state):
    actions = []
    action_list = []

    # get top elements of stacks
    t0 = state[0][- 1]
    t1 = state[1][- 1]
    t2 = state[2][- 1]

    # if top element on the left side is not (left) floor L => append moving top element to the right on action list
    if t0 != 'L':
        actions.append([t0, t1])
    # if top element in the middle is not floor => it could be moved left or right
    if t1 != 'M':
        actions.append([t1, t0])
        actions.append([t1, t2])
    # if top element on the right is not floor => it can be moved to the left
    if t2 != 'R':
        actions.append([t2, t1])

    # sort out not possible actions (B on A, C on A and C on B)
    for i in actions:
        if i != ['B', 'A'] and i != ['C', 'A'] and i != ['C', 'B']:
            action_list.append(i)

    return action_list


# checks if goalState is reached
def isGoal(state):
    if state == goalState:
        return True
    return False


def rearangeBlocks(initial_state, goal_state):
    state = initial_state

    last_state = []
    state_before_last = []

    while not isGoal(state):
        # for i in range(10): # for debugging purposes
        actions = get_possible_actions(state)
        # -----> how to select an action? <-----

        # debugging print outs
        print("current state:", state)
        print("laststate:", last_state)
        print("state before laststate:", state_before_last)
        print("Actions", actions)

        # save states, to look if going back
        state_before_last = copy.deepcopy(last_state)
        last_state = copy.deepcopy(state)

        # Attempt to make the move first and check if this will create an infinite loop
        temp1 = copy.deepcopy(state)
        temp2 = copy.deepcopy(state)
        if len(actions) == 1:
            action = actions[0]
        else:
            action = actions[0]
            moveBlock(temp1, action[0], action[1])
            action = actions[1]
            moveBlock(temp2, action[0], action[1])
            if temp1 == state_before_last:
                action = actions[1]
            else:
                action = actions[0]

        # last_action = action
        moveBlock(state, action[0], action[1])
        print("")
    print(state)


# run the planning algorithm
rearangeBlocks(initialState, goalState)
print("finished")
