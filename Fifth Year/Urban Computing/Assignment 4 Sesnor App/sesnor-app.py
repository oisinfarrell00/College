import math
import boto3
import random
import datetime as dt
from datetime import timedelta
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import tkinter as tk
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

table_name = 'User2'
dynamodb_client = boto3.client('dynamodb')

# Create figure for plotting
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
xs = []
ys = []

cost_of_electricity = 0


def animate(i, xs, ys):
    data = {
        'date_time': {
            'S': str((dt.datetime.now()-timedelta(seconds=3)).strftime("%d/%m/%Y %H:%M:%S"))
        }
    }

    data = {
        'date_time': {
            'S': '11/11/2022 12:31:55'
        }
    }

    resp = dynamodb_client.get_item(TableName=table_name, Key=data)

    if resp['ResponseMetadata']['HTTPHeaders']['content-length'] != '2':
        status = resp['Item']['Status']['S']
        cost = 2*(0, 1)[status == 'ON']+random.uniform(0, 5)
        print(status+":"+str(cost))
        print((dt.datetime.now()-timedelta(seconds=3)
               ).strftime("%d/%m/%Y %H:%M:%S"))
    else:
        status = 'ERROR'
        cost = 0
        print(status+":"+str(cost))

    global cost_of_electricity
    cost_of_electricity = cost_of_electricity + cost

    xs.append(dt.datetime.now().strftime('%H:%M:%S'))
    ys.append(cost_of_electricity)

    xs = xs[-20:]
    ys = ys[-20:]

    ax.clear()
    ax.plot(xs, ys)
    ax.set_ylim([0, 60])

    # Format plot
    plt.xticks(rotation=45, ha='right')
    plt.subplots_adjust(bottom=0.30)
    plt.title('How much is opening your fridge costing you?')
    plt.ylabel('€')


# Set up plot to call animate() function periodically
ani = animation.FuncAnimation(fig, animate, fargs=(xs, ys), interval=1000)
plt.show()
