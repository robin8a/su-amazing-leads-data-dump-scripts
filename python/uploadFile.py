from google.cloud import storage
3
4
# Setting credentials using the downloaded JSON file
5
client = storage.Client.from_service_account_json(json_credentials_path='credentials-python-storage.json')
6
7
# Creating bucket object
8
bucket = client.get_bucket('py-python')
9
10
# Name of the object to be stored in the bucket
11
object_name_in_gcs_bucket = bucket.blob('my_first_gcs_upload.png')
12
13
# Name of the object in local file system
14
object_name_in_gcs_bucket.upload_from_filename('gcs.png')