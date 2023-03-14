from google.oauth2 import service_account
from google.cloud import storage

# Set the name of your bucket and the name of the file you want to access
bucket_name = 'pointing-experiment'
file_name = '2023-02-23T09:11:52_50215/export0/output-0'

# Load the JSON key file and create credentials from it
credentials = service_account.Credentials.from_service_account_file('C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Dissertation\\Experiments\\Experiment Data\\pointing-experiment-v2.json')

# Create a client object to access your bucket
client = storage.Client(credentials=credentials)

# Get a reference to your bucket
bucket = client.get_bucket(bucket_name)

# Get a reference to the blob (i.e. the file) you want to access
blob = bucket.blob(file_name)

# Download the contents of the file as a bytes object
file_contents = blob.download_as_bytes()

# Do something with the file contents
print(file_contents)
