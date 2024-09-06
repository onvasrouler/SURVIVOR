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

bar_length = 60

url_enabled = {
    "employees": False,
    "customers": True,
    "clothes": False,
    "encounters": True,
}

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
if bearrer_token:
    request_headers["Authorization"] = "Bearer " + bearrer_token
else:
    print("Logging in ...")
    login_response = requests.post(login_url, json=login_data, headers=request_headers)
    print(login_response.json())
    request_headers["Authorization"] = "Bearer " + login_response.json()["access_token"]
    print("Logged in successfully")

errors = []    

    
def treat_errors(e, url):
    print(e)
    errors.append({"url": url, "error": e})

def print_errors_summary():
    if len(errors) == 0:
        print("No errors occurred !")
        return
    print("Errors:")
    for error in errors:
        print("an error occurred in " + error["url"] + " with the following message: " + str(error["error"]))
        
def progress_bar(current, total, name):
    if not total or not current:
        name = "error"
        current = 0
        total = 1
    middle_bar_length = bar_length - 6
    name_length = len(name) + 2

    half_top_bar = "=" * round((int(bar_length) - name_length) / 2)
    top_bar = half_top_bar + " " + name + " " + half_top_bar
    bottom_bar = "=" * bar_length

    progress = int(current) / int(total)
    
    block = int(middle_bar_length * progress)
    bar = "|| " + "=" * block + "-" * (middle_bar_length - block) + " ||"

    print(top_bar)
    print(bar)
    print(bottom_bar)
    
def clear_progress_bar():
    print("\033[A" + " " * bar_length + "\033[A")
    print("\033[A" + " " * bar_length + "\033[A")
    print("\033[A" + " " * bar_length + "\033[A")
    
def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')


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
        treat_errors(e, url)
        return None

clear_screen()

def fetch_employee():
    # --------------------- EMPLOYEE ---------------------
    try:
    # get employees
        api_employee = make_request(base_url + "/api/employees")
        for employee in api_employee:
            try:
                progress_bar(str(api_employee.index(employee)), str(len(api_employee)), "employee")
                
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

                clear_progress_bar()
            except Exception as e:
                treat_errors(e, base_url + "/api/employees/" + str(employee["id"]))
                continue
    except Exception as e:
        treat_errors(e, base_url + "/api/employees")
        pass
    clear_screen()

def fetch_customers():
    # --------------------- CUSTOMER ---------------------
    try:
        # get costumers
        api_customer = make_request(base_url + "/api/customers")
        for customer in api_customer:
            try:
                progress_bar(str(api_customer.index(customer)), str(len(api_customer)), "customer #" + str(customer["id"]))

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
                
                encounter = make_request(base_url + "/api/encounters/customer/" + str(customer["id"]))
                if db["customer"].find_one({"id": customer["id"]}):
                    db["customer"].update_one({"id": customer["id"]}, {"$set": {"encounters": encounter}})
                
                fetch_clothes(customer)
                clear_progress_bar()
            except Exception as e:
                treat_errors(e, base_url + "/api/customers/" + str(customer["id"]))
                continue
            
    except Exception as e:
        treat_errors(e, base_url + "/api/customers")
        pass
    clear_screen()


def fetch_clothes(customer=None):
    if not customer:
        return
    try:
        # get costumer clothes
        clothes = make_request(base_url + "/api/customers/" + str(customer["id"]) + "/clothes")
        if db["customer"].find_one({"id": customer["id"]}):
            db["customer"].update_one({"id": customer["id"]}, {"$set": {"clothes": clothes}})
        # --------------------- CLOTH ---------------------
        for cloth in clothes:
            try:
                progress_bar(str(clothes.index(cloth)), str(len(clothes)), "cloth")
                
                #cloth image
                cloth_image = make_request(base_url + "/api/clothes/" + str(cloth["id"]) + "/image", True)
                if not cloth_image:
                    print("no image found for cloth id: " + str(cloth["id"]))
                else:
                    query = {"cloth_id": str(cloth["id"]), "image": cloth_image}
                    if not db["cloth_image"].find_one({"cloth_id": str(cloth["id"])}):
                        db["cloth_image"].insert_one(query)

                clear_progress_bar()
            except Exception as e:
                treat_errors(e, base_url + "/api/clothes/" + str(cloth["id"]))
                continue
    except Exception as e:
        treat_errors(e, base_url + "/api/customers/" + str(customer["id"]) + "/clothes")
        pass
        

def fetch_encounters():
    try:

    # --------------------- ENCOUNTER ---------------------
        api_encounter = make_request(base_url + "/api/encounters")
        print("fetching encounters")
        for encounter in api_encounter:
            try:
                progress_bar(str(api_encounter.index(encounter)), str(len(api_encounter)), "encounter")
                if not db["smallencounter"].find_one(encounter):
                    db["smallencounter"].insert_one(encounter)
                    
                full_encounter = make_request(base_url + "/api/encounters/" + str(encounter["id"]))
                if not db["encounter"].find_one(full_encounter):
                    db["encounter"].insert_one(full_encounter)
                clear_progress_bar()
            except Exception as e:
                treat_errors(e, base_url + "/api/encounters/" + str(encounter["id"]))
                continue
    except Exception as e:
        treat_errors(e, base_url + "/api/encounters")
        pass
    clear_screen()
        
def fetch_tips():
    try:
        # --------------------- TIP ---------------------
        api_tip = make_request(base_url + "/api/tips")
        for tip in api_tip:
            try:
                progress_bar(str(api_tip.index(tip)), str(len(api_tip)), "tip")
    
                if not db["tip"].find_one(tip):
                    db["tip"].insert_one(tip)
            except Exception as e:
                treat_errors(e, base_url + "/api/tips/" + str(tip["id"]))
                continue
            clear_progress_bar()
    except Exception as e:
        treat_errors(e, base_url + "/api/tips")
        pass
    clear_screen()

def fetch_events():
    try:
        # --------------------- EVENT ---------------------
        api_event = make_request(base_url + "/api/events")
        for event in api_event:
            try:
                progress_bar(str(api_event.index(event)), str(len(api_event)), "event")
                print("treating event id: " + str(event["id"]) + " progress: " + str(api_event.index(event)) + "/" + str(len(api_event)))
                if not db["smallevent"].find_one(event):
                    db["smallevent"].insert_one(event)
                
                full_event = make_request(base_url + "/api/events/" + str(event["id"]))
                if not db["event"].find_one(full_event):
                    db["event"].insert_one(full_event)
                clear_progress_bar()
            except Exception as e:
                treat_errors(e, base_url + "/api/events/" + str(event["id"]))
                continue
    except Exception as e:
        treat_errors(e, base_url + "/api/events")
        pass
    clear_screen()
        
def fetch_all():
    fetch_employee()
    fetch_customers()
    fetch_encounters()
    fetch_tips()
    fetch_events()
    clear_screen()

try :
    fetch_encounters()
    fetch_tips()
    fetch_events()
    clear_screen()
except Exception as e:
    treat_errors(e, "fetch_all")
    pass
except KeyboardInterrupt as e:
    print("Script Stopped")
    print_errors_summary()
