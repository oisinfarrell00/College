# Lab work 2: Build a planner
## General
In this lab you will have two tasks.

1. Start with building a STRIPS-planner using Prolog or an object-oriented programming language (e.g., Java or Python). Take a picture of the code and hand in!

2. Also, create a problem space graph for the STRIPS problem. (Look at the slides of search algorithms and the graphs for the different search algorithms). The search graph can look like:
Skärmavbild 2020-11-03 kl. 15.20.42.png
 

3. If you have time and want to implement a program, build a planner using JASON and AgentSpeak, see instructions below. This is an additional lab task and you do not have to hand in this task!

## 1) Build a STRIPS planner that moves blocks
Problem space graph (programming using Prolog)
Create a problem space graph (search space) with nodes and arcs explaining all possible moves from intitial state to goal state.
The room and the positions of the blocks looks like:

Start position:  

block1.png

Goal Position:

block2.png


### Environment:

Floor1, Floor2, Floor3

Start position (Initial phase) : 

on(a, b),

on(b, c),

on(c, Floor-1)       

For the planning: You can only move one block at the time and you only move one step at the time.

on(a, Floor2),

on(b, c),

on(c, Floor1)

So after the first move, the room will look like: block3.png

 

Note that the B-block cannot be on A-block. Moreover, the C-block cannot be on either B-block or A-block.

*) Build a STRIPS planner that moves blocks from one side of the room to the other. 

 

2) Create a problem space graph for the STRIPS problem
Provide a sketch over the problem space search that you got for your program. 

 

