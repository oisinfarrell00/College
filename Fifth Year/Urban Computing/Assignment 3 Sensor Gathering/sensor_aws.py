import boto3
import RPi.GPIO as GPIO
import time
from datetime import datetime

GPIO.setmode(GPIO.BOARD)

pin_to_circuit = 7

table_name = "DynamoDB"
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
		now=datetime.now()
		dt_string_date = now.strftime("%d/%m/%Y")
		dt_string_time = now.strftime("%H:%M:%S")
		ttc = rc_time(pin_to_circuit)
		data = {
			'date_time' : {'S':dt_string_date+" "+dt_string_time}, 'Date' : {'S':dt_string_date}, 'Time' : {'S':dt_string_time}, 'TTC' : {'S':str(ttc)}, 'Status' : {'S':('ON', 'OFF')[ttc>10000]}
		}
		dynamodb_client.put_item(TableName=table_name, Item=data)
		print(str(ttc))
		reading+=1
		
except Exception as e:
	print(e)
finally:
	GPIO.cleanup()
	
print("success")
