#!/usr/bin/env python

import requests
from pymongo import MongoClient
import os
from dotenv import load_dotenv
import json

load_dotenv("./.env")
bearrer_token = ""

base_url = os.getenv("BASE_URL")
api_key = os.getenv("API_KEY")
jwt_token = os.getenv("JWT_TOKEN")
mongo_uri = os.getenv("MONGO_URI")
email = os.getenv("MAIL")
password = os.getenv("PASSWORD")

print('connecting to ' + mongo_uri)
client = MongoClient(mongo_uri)
db = client[os.getenv("DB_NAME")]

login_url = base_url + "/api/employees/login"
login_data = {
    "email": email,
    "password": password
}
request_headers = {
    "X-Group-Authorization": api_key,
}

login_response = requests.post(login_url, json=login_data, headers=request_headers)
print(login_response.json())
request_headers["Authorization"] = "Bearer " + login_response.json()["access_token"]

errors = []

def make_request(url, is_image=False):
    try:
        response = requests.request("get", url, headers=request_headers)
        if response.status_code != 200:
            print("Error: " + str(response.status_code))
            if not is_image:
                print(response.json())
            else:
                print(response)
            return None
        if not is_image:
            return response.json()
        else:
            return response.content
    except Exception as e:
        print(e)
        errors.append(e)
        return None


# --------------------- EMPLOYEE ---------------------
try: 
    # get employees
    api_employee = make_request(base_url + "/api/employees")
    for employee in api_employee:
        try:
            print("treating employee id: " + str(employee["id"]) + " progress: " + str(api_employee.index(employee)) + "/" + str(len(api_employee)))
            
            # get employees small data
            if not db["smallemployee"].find_one(employee):
                db["smallemployee"].insert_one(employee)

            # get employees full data
            full_employee = make_request(base_url + "/api/employees/" + str(employee["id"]))
            if not db["employee"].find_one(full_employee):
                db["employee"].insert_one(full_employee)
            
            # get employees image
            employee_image = make_request(base_url + "/api/employees/" + str(employee["id"]) + "/image", True)
            query = {"employee_id": str(employee["id"]), "image": employee_image}
            if not db["employee_image"].find_one(query):
                db["employee_image"].insert_one(query)

        except Exception as e:
            print(e)
            errors.append(e)
            continue
except Exception as e:
    print(e)
    errors.append(e)
    pass


# --------------------- CUSTOMER ---------------------
try:
    # get costumers
    api_customer = make_request(base_url + "/api/customers")
    for customer in api_customer:
        try:
            print("treating customer id: " + str(customer["id"]) + " progress: " + str(api_customer.index(customer)) + "/" + str(len(api_customer)))

            # get costumers small data
            if not db["smallcustomer"].find_one(customer):
                db["smallcustomer"].insert_one(customer)

            # get costumers full data
            full_customer = make_request(base_url + "/api/customers/" + str(customer["id"]))
            if not db["customer"].find_one(full_customer):
                db["customer"].insert_one(full_customer)
            
            # get costumers image
            customer_image = make_request(base_url + "/api/customers/" + str(customer["id"]) + "/image", True)
            query = {"customer_id": str(customer["id"]), "image": customer_image}
            if not db["customer_image"].find_one(query):
                db["customer_image"].insert_one(query)

            # get costumers payment history
            payments_history = make_request(base_url + "/api/customers/" + str(customer["id"]) + "/payments_history")
            if db["customer"].find_one({"id": customer["id"]}):
                db["customer"].update_one({"id": customer["id"]}, {"$set": {"payments_history": payments_history}})
                
            # get costumer clothes
            clothes = make_request(base_url + "/api/customers/" + str(customer["id"]) + "/clothes")
            if db["customer"].find_one({"id": customer["id"]}):
                db["customer"].update_one({"id": customer["id"]}, {"$set": {"clothes": clothes}})
                
            # --------------------- CLOTH ---------------------
            for cloth in clothes:
                try:
                    print("treating cloth id: " + str(cloth["id"]) + " progress: " + str(clothes.index(cloth)) + "/" + str(len(clothes)))
                    
                    #cloth image
                    cloth_image = make_request(base_url + "/api/clothes/" + str(cloth["id"]) + "/image", True)
                    query = {"cloth_id": str(cloth["id"]), "image": cloth_image}
                    if not db["cloth_image"].find_one(query):
                        db["cloth_image"].insert_one(query)

                except Exception as e:
                    print(e)
                    errors.append(e)
                    continue
        except Exception as e:
            print(e)
            errors.append(e)
            continue
            
except Exception as e:
    print(e)
    errors.append(e)
    pass

print(errors)