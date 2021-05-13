# Lab work 4: Build an agent system
## Agents and Agent systems
### Task
Your task is to create an agent system.

Your task is to build your own multi-agent system. Start the lab by implementing a simple program in GAMA, see instructions below. Choose one of the tasks 1) with, a and b, or 2). You can of course do both tasks. 

 

Required Software and/or Services
1)  GAMA and / or 2) Eclipse IDE and Java.

Create an agent system.
Your task is to build your own multi-agent system in JASON. 

The problem for your agents is: doing search and rescue in a building. They need to help each other in the task of exploring the building and locating victims. You can start with the cleaning robots example and modify it for the agent system.

You will have to make the environment into a building with rooms.  A simple way is to have structure, which lists the connections (doors) from room to room on the graph. You can even make a routine to randomly generate the building map. Agents, then, must use the connections to move from square to square on the grid where each square is a room. Your will need to add functions to the environment to do moves.

The agents do not have access to the building map, they must explore the rooms and make a map (add intelligence, i.e., beliefs to their agent to represent the map). To make this efficient, each agent will need to tell the others what they have found and what they are going. Try this with at least their agents to show they explore the building efficiently (no unneeded double coverage of rooms). When they find a victim have the agents evacuate the victim and resume the search.