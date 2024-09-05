#!/usr/bin/env python

import requests
from pymongo import MongoClient

if __name__ == "__main__":
    url = "https://soul-connection.fr/api/tips"
    api_key = "bf0d22904b98ad48a9cbf9251758ce74"
    jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImVtYWlsIjoiZXRpZW5uZS5yb3Vzc2VsQHNvdWwtY29ubmVjdGlvbi5mciIsIm5hbWUiOiJFdGllbm5lIiwic3VybmFtZSI6IlJvdXNzZWwiLCJleHAiOjE3MjcyNTMyNjh9.xljCIaLaGdI7d9OeSlYJkRFkiDE_4glqXagdCdGbPL8"

    client = MongoClient("mongodb://localhost:27017/")
    db = client.soul_connection
    tipscollection = db.tips

    headers = {
        "X-Group-Authorization": api_key,
        "Authorization": f"Bearer {jwt_token}"
    }

    datas = []

    response = requests.get(url, headers=headers)

    tips = response.json()

    for tip in tips:
        data = {'tips_id' : tip['id'],
                'title' : tip['title'],
                'tip' : tip['tip']
                }

        #datas.append(data)
        print (data['tips_id'])
        tipscollection.insert_one(data)
    

    print("fin")