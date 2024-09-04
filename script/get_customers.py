#!/usr/bin/env python

import requests
from pymongo import MongoClient

if __name__ == "__main__":
    url = "https://soul-connection.fr/api/customers"
    api_key = "bf0d22904b98ad48a9cbf9251758ce74"
    jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImVtYWlsIjoiZXRpZW5uZS5yb3Vzc2VsQHNvdWwtY29ubmVjdGlvbi5mciIsIm5hbWUiOiJFdGllbm5lIiwic3VybmFtZSI6IlJvdXNzZWwiLCJleHAiOjE3MjcyNTMyNjh9.xljCIaLaGdI7d9OeSlYJkRFkiDE_4glqXagdCdGbPL8"

    client = MongoClient("mongodb://localhost:27017/")
    db = client.soul_connection
    collection = db.customers

    headers = {
        "X-Group-Authorization": api_key,
        "Authorization": f"Bearer {jwt_token}"
    }

    datas = []

    response = requests.get(url, headers=headers)

    customers = response.json()

    for customer in customers:
        url = "https://soul-connection.fr/api/customers/" + str(customer['id'])
        response = requests.get(url, headers=headers)
        customer = response.json()
        
        data = {'id' : customer['id'],
                'email' : customer['email'],
                'name' : customer['name'],
                'surname' : customer['surname'],
                'birth_date' : customer['birth_date'],
                'gender' : customer['gender'],
                'description' : customer['description'],
                'astrological_sign' : customer['astrological_sign'],
                'phone_number' : customer['phone_number'],
                'address' : customer['address'],
                'clothes' : []
                }
        
        url = "https://soul-connection.fr/api/customers/" + str(customer['id']) + "/clothes"
        response = requests.get(url, headers=headers)
        clothes = response.json()

        for clothe in clothes:
            print("clothe ", clothe['id'])
            try:
                url = "https://soul-connection.fr/api/clothes/" + str(clothe['id']) + "/image"
                response = requests.get(url, headers=headers)
                image = response.content
            except:
                image = 0


            data['clothes'].append({'id' : clothe['id'], 'type' : clothe['type'], 'image' : image})

        datas.append(data)
        collection.insert_one(data)
        print (data['id'])

    print("fin")

