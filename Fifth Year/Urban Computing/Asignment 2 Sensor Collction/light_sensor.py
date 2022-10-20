import RPi.GPIO as GPIO
import time
from datetime import datetime

GPIO.setmode(GPIO.BOARD)

file = open("/media/pi/ESD-USB/light_sensor_data.csv", "w")
file.write("DATE,TIME,TIME TO CHARGE CAPACITOR\n")

pin_to_circuit = 7


def rc_time(pint_to_circuit):
    count = 0

    GPIO.setup(pin_to_circuit, GPIO.OUT)
    GPIO.output(pint_to_circuit, GPIO.LOW)
    time.sleep(0.5)

    GPIO.setup(pin_to_circuit, GPIO.IN)

    while(GPIO.input(pin_to_circuit) == GPIO.LOW):
        count += 1

    return count


try:
    while True:
        now = datetime.now()
        dt_string_date = now.strftime("%d/%m/%Y")
        dt_string_time = now.strftime("%H:%M:%S")
        data_entry = str(dt_string_date) + "," + \
            str(dt_string_time) + "," + str(rc_time(pin_to_circuit))
        print(data_entry)
        file.write(data_entry + "\n")

except KeyboardInterrupt:
    pass
finally:
    GPIO.cleanup()
    file.close()
