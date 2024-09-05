#!/usr/bin/env python

import requests
from pymongo import MongoClient

if __name__ == "__main__":
    url = "https://soul-connection.fr/api/employees"
    api_key = "bf0d22904b98ad48a9cbf9251758ce74"
    jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImVtYWlsIjoiZXRpZW5uZS5yb3Vzc2VsQHNvdWwtY29ubmVjdGlvbi5mciIsIm5hbWUiOiJFdGllbm5lIiwic3VybmFtZSI6IlJvdXNzZWwiLCJleHAiOjE3MjcyNTMyNjh9.xljCIaLaGdI7d9OeSlYJkRFkiDE_4glqXagdCdGbPL8"

    client = MongoClient("mongodb://localhost:27017/")
    db = client.soul_connection
    employeescollection = db.employees

    headers = {
        "X-Group-Authorization": api_key,
        "Authorization": f"Bearer {jwt_token}"
    }

    datas = []

    response = requests.get(url, headers=headers)

    employees = response.json()

    for employee in employees:
        urlemployees = "https://soul-connection.fr/api/employees/" + str(employee['id'])
        responseemployees = requests.get(urlemployees, headers=headers)
        employee = responseemployees.json()

        data = {'employee_id' : employee['id'],
                'email' : employee['email'],
                'name' : employee['name'],
                'surname' : employee['surname'],
                'birth_date' : employee['birth_date'],
                'gender' : employee['gender'],
                'work' : employee['work'],
                'image' :   0
                }

        try:
            urlclothes = "https://soul-connection.fr/api/employees/" + str(employee['id']) + "/image"
            responseimage = requests.get(urlclothes, headers=headers)
            image = responseimage.content
        except:
            image = 0

        data['image'] = image

        #datas.append(data)
        print (data['employee_id'])
        employeescollection.insert_one(data)
    

    print("fin")