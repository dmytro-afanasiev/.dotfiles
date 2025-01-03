#!/bin/python
import requests
import json
import os
import sys
import subprocess
import logging

logs_path = os.path.join(os.path.dirname(__file__), 'script.logs')
logging.basicConfig(filename=logs_path, format='%(levelname)s: %(asctime)s - %(message)s', level=logging.INFO)
logger = logging.getLogger()
logger.info('Got logger')

ACCESS_KEY=os.environ.get('UNSPLASH_KEY')

if not ACCESS_KEY:
    print("KEY is not provided", file=sys.stderr)
    logger.error('ACCESS_KEY env variable was not assigned')
    sys.exit(1)
logger.info('ACCESS_KEY was received')

headers = {
    'Authorization': f'Client-ID {ACCESS_KEY}'
}
params = {
    'orientation': 'landscape',
    #'topics': 'S4MKLAsBB74',
    'query': 'dark',
}

response = requests.get('https://api.unsplash.com/photos/random', headers=headers, params=params)

if not response.ok:
    logger.error(response.json())

logger.info('Got random photo and its metadata')

download_link = response.json()['urls']['raw']
params_download = {
    'w': 1920,
    'h': 1080,
}
response = requests.get(download_link, params=params_download)

if not response.ok:
    logger.error(response.json())
logger.info('The photo was downloaded')

filename = os.path.join(os.path.dirname(__file__), 'wallpaper.jpg')
with open(filename, 'wb') as file:
    file.write(response.content)
logger.info('The photo was written to the file')

completed_process = subprocess.run(['feh', '--bg-fill', filename])
if completed_process.returncode == 0:
    logger.info('Wallpaper successfully set\n')
else:
    logger.error(f'Wallpaper was not set - {completed_process.stdout.decode()}\n')
    sys.exit(1)
