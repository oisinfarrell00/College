import boto3
import time
from datetime import datetime
from bs4 import BeautifulSoup
import requests

table_name = "User2"
dynamodb_client = boto3.client('dynamodb')

URL = "https://www.oilprices.ie/"


def get_oil_price():
    page = requests.get(URL)
    soup = BeautifulSoup(page.content, "html.parser")
    return soup.find("td", text="Dublin").find_next_sibling("td").text


def upload_reading(oil_price):
    now = datetime.now()
    dt_string_date = now.strftime("%d/%m/%Y")
    dt_string_time = now.strftime("%H:%M:%S")
    status = "ON"
    if (13 < now.second < 18 or 27 < now.second < 35 or 53 < now.second < 58):
        status = "ON"
    else:
        status = "OFF"
    data = {
        'date_time': {'S': dt_string_date+" "+dt_string_time},
        'Status': {'S': status},
        'Oil Price(€)': {'S': oil_price}
    }
    resp = dynamodb_client.put_item(TableName=table_name, Item=data)
    success = resp['ResponseMetadata']['HTTPStatusCode'] == 200
    if not success:
        print("Error Uploading")


reading = 0
try:
    oil_price = get_oil_price()
    print("producing...")
    print(oil_price)
    while True:
        upload_reading(oil_price)
        time.sleep(.1)
        reading += 1

except Exception as e:
    print(e)
