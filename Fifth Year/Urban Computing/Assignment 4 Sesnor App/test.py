# IMPORTS
from datetime import timedelta
import datetime as dt
import random
import threading
import time as t
from tkinter import *
from time import strftime
import boto3
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.figure import Figure

# CONSTANTS
BACKGROUND = '#ADD8e6'

# GLOBAL VARIABLES
continuePlotting = False
cost_of_electricity = 0
root = Tk()
xs = []
ys = []
lbl = Label(root, font=('calibri', 40, 'bold'),
            background='purple',
            foreground='white')

# AWS ACCESSING DB
table_name = 'User2'
dynamodb_client = boto3.client('dynamodb')

#
root.config(background=BACKGROUND)
root.geometry("1000x700")
fig = Figure(facecolor=BACKGROUND)

ax = fig.add_subplot(221)
ax.set_facecolor(BACKGROUND)
ax_pi = fig.add_subplot(222)
ax_pi.set_facecolor(BACKGROUND)


def set_graph():
    graph = FigureCanvasTkAgg(fig, master=root)
    graph.get_tk_widget().pack(side="top", fill='both', expand=True)
    return graph


def change_state():
    global continuePlotting
    if continuePlotting == True:
        continuePlotting = False
    else:
        continuePlotting = True


def data_points():
    time = (dt.datetime.now()-timedelta(seconds=3)
            ).strftime("%d/%m/%Y %H:%M:%S")
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
        print(time)
    else:
        status = 'ERROR'
        cost = 0
        print(status+":"+str(cost))
    global cost_of_electricity
    cost_of_electricity = cost_of_electricity + cost
    global xs, ys
    ys.append(cost_of_electricity)
    xs.append(time)


def time():
    string = strftime('%H:%M:%S %p')
    lbl.config(text=string)
    lbl.after(1000, time)


def plotter(graph):
    time()
    global xs, ys
    while continuePlotting:
        ax.cla()
        ax.grid()
        ax.set_xticklabels([])
        data_points()

        ax.set_xlabel("Time")
        ax.set_ylabel("Cost (€)")
        ax.set_title("How much is opening your fridge costing you?")

        xs = xs[-20:]
        ys = ys[-20:]
        ax.set_ylim([0, 60])

        ax.plot(xs, ys, color='orange')

        ax_pi.clear()
        sizes = [cost_of_electricity, 70, 45, 10]
        labels = 'Bathroom Light', 'Fridge Light', 'Sitting Room', 'Logs'
        ax_pi.pie(sizes, labels=labels, autopct='%1.1f%%',
                  shadow=True, startangle=90)
        ax_pi.set_title("Breakdown of all lights")

        graph.draw()
        t.sleep(1)


def gui_handler():
    graph = set_graph()
    change_state()
    threading.Thread(target=plotter, args=[graph]).start()

    # b = Button(root, text="Login",
    #            command=gui_handler, bg="red", fg="white")
    # b.pack()
    lbl.pack(anchor='ne')


def login():
    b = Button(root, text="Login",
               command=gui_handler, bg="red", fg="white")
    b.pack()
    root.mainloop()


if __name__ == '__main__':
    login()
