import os
import urllib3
import hashlib
import time

urllib3.disable_warnings()

download_path = input("Please enter the path to your desired download directory:\n")
num_download = int(input("Enter how many images you'd like to download:\n"))


url = "https://thispersondoesnotexist.com/image"

http = urllib3.PoolManager()

hashes = set()

i = 0
while i < num_download:

    r = http.request("GET", url, preload_content=False)

    hashcode = hashlib.sha1(r.data)

    if hashcode in hashes:
        continue
    else:
        hashes.add(hashcode)

    img_name = f"{i:05d}"

    with open(os.path.join(download_path, f"{img_name}.jpg"), 'wb') as outfile:

        outfile.write(r.data)

    i += 1

    time.sleep(1)

