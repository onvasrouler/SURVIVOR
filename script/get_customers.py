#!/usr/bin/env python

import requests
from pymongo import MongoClient

if __name__ == "__main__":
    url = "https://soul-connection.fr/api/customers"
    api_key = "bf0d22904b98ad48a9cbf9251758ce74"
    jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImVtYWlsIjoiZXRpZW5uZS5yb3Vzc2VsQHNvdWwtY29ubmVjdGlvbi5mciIsIm5hbWUiOiJFdGllbm5lIiwic3VybmFtZSI6IlJvdXNzZWwiLCJleHAiOjE3MjcyNTMyNjh9.xljCIaLaGdI7d9OeSlYJkRFkiDE_4glqXagdCdGbPL8"

    client = MongoClient("mongodb://localhost:27017/")
    db = client.soul_connection
    usercollection = db.customers
    clothescollection = db.clothes

    headers = {
        "X-Group-Authorization": api_key,
        "Authorization": f"Bearer {jwt_token}"
    }

    datas = []

    response = requests.get(url, headers=headers)

    customers = response.json()

    for customer in customers:
        urlcustomers = "https://soul-connection.fr/api/customers/" + str(customer['id'])
        responsecustomers = requests.get(urlcustomers, headers=headers)
        customer = responsecustomers.json()

        urlclothes = "https://soul-connection.fr/api/customers/" + str(customer['id']) + "/clothes"
        responseclothes = requests.get(urlclothes, headers=headers)
        clothes = responseclothes.json()

        clothesIds = []
        for clotheID in clothes:
            clothesIds.append(clotheID['id'])

        data = {'user_id' : customer['id'],
                'email' : customer['email'],
                'name' : customer['name'],
                'surname' : customer['surname'],
                'birth_date' : customer['birth_date'],
                'gender' : customer['gender'],
                'description' : customer['description'],
                'astrological_sign' : customer['astrological_sign'],
                'phone_number' : customer['phone_number'],
                'address' : customer['address'],
                'clothes' : clothesIds
                }
        print(data)
       
        for clothe in clothes:
            existing_clothe = clothescollection.find_one({'id': clothe['id']})
            if existing_clothe:
                print("Clothe " + str(clothe['id']) + " already exists")
            else:
                print("Clothe " + str(clothe['id']) + " does not exist")
                image = 0
                try:
                    url = "https://soul-connection.fr/api/clothes/" + str(clothe['id']) + "/image"
                    response = requests.get(url, headers=headers)
                    image = response.content
                except:
                    image = 0
                new_clothe = {
                    'id': clothe['id'],
                    'type': clothe['type'],
                    'image': image  # Assuming 'image' might not always be present
                }
                clothescollection.insert_one(new_clothe)

        

        datas.append(data)
        print(data)
        print (data['user_id'])
        usercollection.insert_one(data)
    print("fin")