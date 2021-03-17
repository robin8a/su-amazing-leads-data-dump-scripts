from google.cloud import storage
3
4
# Setting credentials using the downloaded JSON file
5
client = storage.Client.from_service_account_json(json_credentials_path='kio-sl-emap-20fc37f5d54d.json')
6
7
# Creating bucket object
8
bucket = client.get_bucket('su-amazing-leads')
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

def upload_local_directory_to_gcs(local_path, bucket, gcs_path):
    assert os.path.isdir(local_path)
    for local_file in glob.glob(local_path + '/**'):
        if not os.path.isfile(local_file):
           upload_local_directory_to_gcs(local_file, bucket, gcs_path + "/" + os.path.basename(local_file))
        else:
           remote_path = os.path.join(gcs_path, local_file[1 + len(local_path):])
           blob = bucket.blob(remote_path)
           blob.upload_from_filename(local_file)


upload_local_directory_to_gcs(local_path, bucket, BUCKET_FOLDER_DIR)