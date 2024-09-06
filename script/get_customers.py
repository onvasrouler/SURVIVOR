
#!/usr/bin/env python

import requests
from pymongo import MongoClient
import base64
import json

if __name__ == "__main__":
    url = "https://soul-connection.fr/api/customers"
    api_key = "bf0d22904b98ad48a9cbf9251758ce74"
    jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImVtYWlsIjoiZXRpZW5uZS5yb3Vzc2VsQHNvdWwtY29ubmVjdGlvbi5mciIsIm5hbWUiOiJFdGllbm5lIiwic3VybmFtZSI6IlJvdXNzZWwiLCJleHAiOjE3MjcyNTMyNjh9.xljCIaLaGdI7d9OeSlYJkRFkiDE_4glqXagdCdGbPL8"

    client = MongoClient("mongodb://host.docker.internal:27017/")
    db = client.soul_connection
    usercollection = db.customers
    clothescollection = db.clothes

    headers = {
        "X-Group-Authorization": api_key,
        "Authorization": f"Bearer {jwt_token}"
    }

    response = requests.get(url, headers=headers)
    customers = response.json()

    for customer in customers:
        urlcustomers = f"https://soul-connection.fr/api/customers/{customer['id']}"
        responsecustomers = requests.get(urlcustomers, headers=headers)
        customer = responsecustomers.json()

        urlclothes = f"https://soul-connection.fr/api/customers/{customer['id']}/clothes"
        responseclothes = requests.get(urlclothes, headers=headers)
        clothes = responseclothes.json()

        clothesIds = [{'id': clothe['id'], 'type': clothe['type']} for clothe in clothes]

        try:
            urlclothes = "https://soul-connection.fr/api/customers/" + str(customer['id']) + "/image"
            responseimage = requests.get(urlclothes, headers=headers)
            image = responseimage.content
        except:
            image = 0

        data = {
            'user_id': customer['id'],
            'email': customer['email'],
            'name': customer['name'],
            'surname': customer['surname'],
            'birth_date': customer['birth_date'],
            'gender': customer['gender'],
            'description': customer['description'],
            'astrological_sign': customer['astrological_sign'],
            'phone_number': customer['phone_number'],
            'address': customer['address'],
            'clothes': clothesIds,
            'image': image
        }

        usercollection.insert_one(data)

        for clothe in clothes:
            existing_clothe = clothescollection.find_one({'clothe_id': clothe['id']})
            if existing_clothe:
                image = 0
                try:
                    url = f"https://soul-connection.fr/api/clothes/{clothe['id']}/image"
                    response = requests.get(url, headers=headers)
                    image = response.content
                except:
                    image = 0
                image_name = f"{customer['id']}_{clothe['id']}.png"

                try:
                    upload_url = "http://localhost:5000/upload"
                    data = {
                        "imageName": image_name,
                        "base64Image": base64.b64encode(image).decode('utf-8')
                    }
                    header = {
                        "Content-Type": "application/json"
                    }
                    response = requests.post(upload_url, headers=header, data=json.dumps(data))
                    if response.status_code == 200:
                        print(f"Image {image_name} uploaded successfully!")
                    else:
                        print(f"Failed to upload image {image_name}. Status Code: {response.status_code}, Response: {response.text}")
                except Exception as e:
                    print(f"Failed to upload image {image_name}. Error: {e}")
            else:
                print(f"Clothe {clothe['id']} does not exist")
                image = 0
                try:
                    url = f"https://soul-connection.fr/api/clothes/{clothe['id']}/image"
                    response = requests.get(url, headers=headers)
                    image = response.content
                except:
                    image = 0

                new_clothe = {
                    'clothe_id': clothe['id'],
                    'image': image
                }
                clothescollection.insert_one(new_clothe)

                image_name = f"{customer['id']}_{clothe['id']}.png"

                try:
                    upload_url = "http://localhost:5000/upload"
                    data = {
                        "imageName": image_name,
                        "type": clothe['type'],
                        "base64Image": base64.b64encode(image).decode('utf-8')
                    }
                    header = {
                        "Content-Type": "application/json"
                    }
                    response = requests.post(upload_url, headers=header, data=json.dumps(data))
                    if response.status_code == 200:
                        print(f"Image {image_name} uploaded successfully!")
                    else:
                        print(f"Failed to upload image {image_name}. Status Code: {response.status_code}, Response: {response.text}")
                except Exception as e:
                    print(f"Failed to upload image {image_name}. Error: {e}")

    print("Process complete")