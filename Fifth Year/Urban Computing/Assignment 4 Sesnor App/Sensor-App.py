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
BEDROOM_LIGHT_LIMIT = 20

# GLOBAL VARIABLES
continuePlotting = False
allow_bedroom = True
create_button = False
done = False
cost_of_electricity = 0
cost_fridge_light = 0
cost_bedroom_light = 0
total_fridge = 0
total_bedroom = 0
root = Tk()
xs = []
ys = []
oil_prices = []
lbl = Label(root, font=('calibri', 40, 'bold'),
            background='#55A4C8',
            foreground='white')

# AWS ACCESSING DB
table_name_2 = 'DynamoDB2'
table_name = 'User2'
dynamodb_client = boto3.client('dynamodb')

#
root.config(background=BACKGROUND)
root.title('Electricty Monitoring App')
root.geometry("1000x700")
fig = Figure(facecolor=BACKGROUND)

ax = fig.add_subplot(221)
ax.set_facecolor(BACKGROUND)
ax_pi = fig.add_subplot(222)
ax_pi.set_facecolor(BACKGROUND)
ax_bar = fig.add_subplot(223)
ax_bar.set_facecolor(BACKGROUND)
ax_oil = fig.add_subplot(224)
ax_oil.set_facecolor(BACKGROUND)


def set_graph():
    graph = FigureCanvasTkAgg(fig, master=root)
    graph.get_tk_widget().pack(side="top", fill='both', expand=True)
    return graph


def turn_off_bedroom_light():
    global allow_bedroom
    allow_bedroom = False


def change_state():
    global continuePlotting
    if continuePlotting == True:
        continuePlotting = False
    else:
        continuePlotting = True


def data_points():
    time = (dt.datetime.now()-timedelta(seconds=1)
            ).strftime("%d/%m/%Y %H:%M:%S")

    data = {
        'date_time': {
            'S': time
        }
    }

    global cost_fridge_light, cost_bedroom_light, allow_bedroom
    resp = dynamodb_client.get_item(TableName=table_name, Key=data)
    if resp['ResponseMetadata']['HTTPHeaders']['content-length'] != '2':
        status = resp['Item']['Status']['S']
        oil_price = resp['Item']['Oil Price(€)']['S']
        oil_price = oil_price[1:len(oil_price)]
        random_offset = random.uniform(-10, 10)
        oil_price = float(oil_price)+random_offset
        cost_fridge_light = (0, 1)[status == 'ON']*oil_price/400
    else:
        status = 'No data for this time, using randomly generated data...'
        cost_fridge_light = 0
        oil_price = random.uniform(625, 630)

    resp2 = dynamodb_client.get_item(TableName=table_name_2, Key=data)
    if resp2['ResponseMetadata']['HTTPHeaders']['content-length'] != '2' and allow_bedroom:
        status = resp2['Item']['Status']['S']
        oil_price = resp2['Item']['Oil Price']['S']
        oil_price = oil_price[1:len(oil_price)]
        random_offset = random.uniform(-10, 10)
        oil_price = float(oil_price)+random_offset
        cost_bedroom_light = (0, 1)[status == 'ON']*oil_price/400
    else:
        status = 'No data for this time, using randomly generated data...'
        cost_bedroom_light = 0
        oil_price = random.uniform(625, 630)

    global cost_of_electricity
    cost_of_electricity = cost_of_electricity + \
        cost_fridge_light + cost_bedroom_light
    global xs, ys, oil_prices
    ys.append(cost_of_electricity)
    xs.append(time)
    oil_prices.append(oil_price)


def clock():
    string = strftime('%H:%M:%S %p')
    lbl.config(text=string)
    lbl.after(1000, clock)


def plotter(graph):
    clock()
    global total_bedroom, total_fridge
    global xs, ys, oil_prices, create_button
    while continuePlotting:
        if total_bedroom >= BEDROOM_LIGHT_LIMIT and not create_button:
            b = Button(root, text="Turn Off Bedroom Light",
                       command=turn_off_bedroom_light, bg="#55A4C8", fg="white")
            b.pack()
            create_button = True
        data_points()
        ax.cla()
        ax.grid()
        ax.set_xticklabels([])

        ax.set_xlabel("Time")
        ax.set_ylabel("Cost (€)")
        ax.set_title("Live Electricity Cost")

        ax_oil.cla()
        ax_oil.grid()
        ax_oil.set_xticklabels([])

        ax_oil.set_xlabel("Time")
        ax_oil.set_ylabel("Cost Of Oil(€)")
        ax_oil.set_title("Live Oil Price")

        xs = xs[-20:]
        ys = ys[-20:]
        oil_prices = oil_prices[-20:]
        ax.set_ylim([0, 60])
        ax_oil.set_ylim([550, 700])

        ax.plot(xs, ys, color='orange')
        ax_oil.plot(
            xs, oil_prices)

        ax_pi.clear()

        total_bedroom = total_bedroom + cost_bedroom_light
        total_fridge = total_fridge + cost_fridge_light

        data = {'Bedroom Light': total_bedroom, 'Fridge Light': total_fridge,
                'Sitting Room': 45, 'Bathroom Light': 10}
        names = [key for key, value in data.items() if value != 0]
        values = [value for value in data.values() if value != 0]

        ax_pi.pie(values, labels=names, autopct='%1.1f%%',
                  shadow=True, startangle=90)
        ax_pi.set_title("Breakdown of all lights")

        ax_bar.clear()
        bar_width = [total_bedroom, total_fridge, 3, 5]
        bar_y = [0, 10, 20, 30]
        labels = ["Bedroom Lights", "Fridge Light", "Water", "GAS"]
        ax_bar.set_yticks(bar_y, labels=labels)
        ax_bar.set_title("Daily Usage Limits", fontsize=8)
        ax_bar.barh(bar_y, bar_width, height=4)
        ax_bar.vlines(BEDROOM_LIGHT_LIMIT, 0, 30,
                      color='red', label='Daily Price Limit')

        graph.draw()
        t.sleep(.5)


def login():
    graph = set_graph()
    change_state()
    threading.Thread(target=plotter, args=[graph]).start()
    lbl.pack(anchor='ne')
    root.mainloop()


if __name__ == '__main__':
    login()
