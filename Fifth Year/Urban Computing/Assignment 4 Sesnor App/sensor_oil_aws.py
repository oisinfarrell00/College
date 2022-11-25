import boto3
import RPi.GPIO as GPIO
import time
from datetime import datetime
import requests
from bs4 import BeautifulSoup

URL = "https://www.oilprices.ie/"

GPIO.setmode(GPIO.BOARD)

pin_to_circuit = 7

table_name = "DynamoDB2"
dynamodb_client = boto3.client('dynamodb')

def rc_time(pint_to_circuit):
    count = 0

    GPIO.setup(pin_to_circuit, GPIO.OUT)
    GPIO.output(pint_to_circuit, GPIO.LOW)
    time.sleep(0.2)

    GPIO.setup(pin_to_circuit, GPIO.IN)

    while(GPIO.input(pin_to_circuit) == GPIO.LOW):
        count += 1

    return count
	
reading = 0
try:
	while reading<50:
		page = requests.get(URL)
		soup = BeautifulSoup(page.content, "html.parser")
		oil_price_dub = soup.find("td", text="Dublin").find_next_sibling("td").text
		now=datetime.now()
		dt_string_date = now.strftime("%d/%m/%Y")
		dt_string_time = now.strftime("%H:%M:%S")
		ttc = rc_time(pin_to_circuit)
		data = {
			'date_time' : {'S':dt_string_date+" "+dt_string_time}, 'Status' : {'S':('ON', 'OFF')[ttc>10000]}, 'Oil Price' : {'S':oil_price_dub}
		}
		dynamodb_client.put_item(TableName=table_name, Item=data)
		print(str(ttc))
		reading+=1
		
except Exception as e:
	print(e)
finally:
	GPIO.cleanup()
	
print("success")
