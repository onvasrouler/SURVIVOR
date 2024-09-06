#!/usr/bin/env python

import requests
from pymongo import MongoClient
import os
from dotenv import load_dotenv
import json
import threading

load_dotenv("./.env")
bearrer_token = ""

base_url = os.getenv("BASE_URL")
api_key = os.getenv("API_KEY")
jwt_token = os.getenv("JWT_TOKEN")
mongo_uri = os.getenv("MONGO_URI")
email = os.getenv("MAIL")
password = os.getenv("PASSWORD")

bar_length = 60
error_file_name = "errors.txt"
store_small_data = {
    "employees": True,
    "customers": True,
    "encounters": True,
    "events": True,
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
progress_bars = {}

    
def treat_errors(e, url):
    print(e)
    errors.append({"url": url, "error": e})

def output_in_file(data, file_name):
    with open(file_name, "a") as file:
        file.write(data + "\n")

def print_errors_summary():
    if len(errors) == 0:
        print("No errors occurred !")
        return
    print("Errors:")
    with open(error_file_name, "a") as error_file:
        for error in errors:
            error_message = "an error occurred in " + error["url"] + " with the following message: " + str(error["error"])
            #print(error_message)
            error_file.write(error_message + "\n")
        
def update_progress_bar(current, total, name, id = None):
    clear_screen()
    progress_bars[name] = {"current": current, "total": total, "id": id}
    for key_bar, bar in progress_bars.items():
        if bar["total"] == 0:
            bar["total"] = 1
        if round(int(bar["current"]) / int(bar["total"])) == 1:
            continue
        if not bar["total"] or not bar["current"]:
            key_bar = "error"
            bar["current"] = 0
            bar["total"] = 1
        if bar["id"]:
            key_bar = key_bar + " #" + str(bar["id"])
        middle_bar_length = bar_length - 6
        name_length = len(key_bar) + 2

        half_top_bar = "=" * round((int(bar_length) - name_length) / 2)
        top_bar = half_top_bar + " " + key_bar + " " + half_top_bar
        bottom_bar = "=" * bar_length

        progress = int(bar["current"]) / int(bar["total"])
        
        block = int(middle_bar_length * progress)
        bar = "|| " + "=" * block + "-" * (middle_bar_length - block) + " ||"

        print(top_bar)
        print(bar)
        print(bottom_bar)
    
def clear_progress_bar():
    number_of_spaces = bar_length + 1
    number_of_lines = 4
    for i in range(number_of_lines):
        print("\033[A" + " " * number_of_spaces + "\033[A")
    
def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')


def make_request(url, is_image=False):
    try:
        response = requests.request("get", url, headers=request_headers)
        if response.status_code != 200:
            if not is_image:
                print(response.json())
                treat_errors("Error fetching : " + url + ", Got status code :" + str(response.status_code) + ", Got response message :" + json.dumps(response.json()), url)
            else:
                print(response)
                treat_errors("Error fetching : " + url + ", Got status code :" + str(response.status_code), url)
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
                update_progress_bar(str(api_employee.index(employee)), str(len(api_employee)), "employee")
                
                # get employees small data
                if store_small_data["employees"]:
                    employee = {**employee, "small_employee_id": str(employee["id"]), "employee_id": str(employee["id"])}
                    if not db["small_employee"].find_one(employee):
                        db["small_employee"].insert_one(employee)

                # get employees full data
                full_employee = make_request(base_url + "/api/employees/" + str(employee["id"]))
                full_employee = {**full_employee, "employee_id": str(employee["id"])}
                if not db["employee"].find_one(full_employee):
                    db["employee"].insert_one(full_employee)
                
                # get employees image
                employee_image = make_request(base_url + "/api/employees/" + str(employee["id"]) + "/image", True)
                query = {"employee_id": str(employee["id"]), "employee_image_id": str(employee["id"]), "image": employee_image}
                if not db["employee_image"].find_one(query):
                    db["employee_image"].insert_one(query)

            except Exception as e:
                treat_errors(e, base_url + "/api/employees/" + str(employee["id"]))
                continue
    except Exception as e:
        treat_errors(e, base_url + "/api/employees")
        pass
    

def fetch_customers():
    # --------------------- CUSTOMER ---------------------
    try:
        # get costumers
        api_customer = make_request(base_url + "/api/customers")
        for customer in api_customer:
            try:
                update_progress_bar(str(api_customer.index(customer)), str(len(api_customer)), "customer", customer["id"])

                # get costumers small data
                if store_small_data["customers"]:
                    customer = {**customer, "small_customer_id": str(customer["id"]), "customer_id": str(customer["id"])}
                    if not db["small_customer"].find_one(customer):
                        db["small_customer"].insert_one(customer)

                # get costumers full data
                full_customer = make_request(base_url + "/api/customers/" + str(customer["id"]))
                full_customer = {**full_customer, "customer_id": str(customer["id"])}
                if not db["customer"].find_one(full_customer):
                    db["customer"].insert_one(full_customer)
                
                # get costumers image
                customer_image = make_request(base_url + "/api/customers/" + str(customer["id"]) + "/image", True)
                query = {"customer_id": str(customer["id"]), "customer_image_id": str(customer["id"]),"image": customer_image}
                if not db["customer_image"].find_one(query):
                    db["customer_image"].insert_one(query)

                # get costumers payment history
                payments_history = make_request(base_url + "/api/customers/" + str(customer["id"]) + "/payments_history")
                if db["customer"].find_one({"id": customer["id"]}):
                    db["customer"].update_one({"id": customer["id"]}, {"$set": {"payments_history": payments_history}})
                
                encounter = make_request(base_url + "/api/encounters/customer/" + str(customer["id"]))
                if db["customer"].find_one({"id": customer["id"]}):
                    db["customer"].update_one({"id": customer["id"]}, {"$set": {"encounters": encounter}})
                
                db["customer"].update_one({"id": customer["id"]}, {"$set": {"encounters": ""}})
                fetch_clothes(customer)
            except Exception as e:
                treat_errors(e, base_url + "/api/customers/" + str(customer["id"]))
                continue
            
    except Exception as e:
        treat_errors(e, base_url + "/api/customers")
        pass
    


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
                update_progress_bar(str(clothes.index(cloth)), str(len(clothes)), "cloth")
                
                #cloth image
                cloth_image = make_request(base_url + "/api/clothes/" + str(cloth["id"]) + "/image", True)
                if not cloth_image:
                    print("no image found for cloth id: " + str(cloth["id"]))
                else:
                    query = {"clothe_id": str(cloth["id"]), "cloth_image_id": str(cloth["id"]), "customer_id": str(customer["id"]), "image": cloth_image}
                    if not db["clothe_image"].find_one({"cloth_id": str(cloth["id"])}):
                        db["clothe_image"].insert_one(query)

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
        buffer = []
        print("fetching encounters")
        for encounter in api_encounter:
            try:
                update_progress_bar(str(api_encounter.index(encounter)), str(len(api_encounter)), "encounter")

                if store_small_data["encounters"]:
                    encounter = {**encounter, "small_encounter_id": str(encounter["id"]), "encounter_id": str(encounter["id"])}
                    if not db["small_encounter"].find_one(encounter):
                        db["small_encounter"].insert_one(encounter)
                    
                full_encounter = make_request(base_url + "/api/encounters/" + str(encounter["id"]))
                full_encounter = {**full_encounter, "encounter_id": str(encounter["id"])}
                if not db["encounter"].find_one(full_encounter):
                    db["encounter"].insert_one(full_encounter)
                if db["customer"].find_one({"customer_id": str(full_encounter["customer_id"])}):
                    
                    db["customer"].update_one({"customer_id": str(full_encounter["customer_id"])}, {"$addToSet": {"encounters": full_encounter}})

                
                
            except Exception as e:
                treat_errors(e, base_url + "/api/encounters/" + str(encounter["id"]))
                continue
    except Exception as e:
        treat_errors(e, base_url + "/api/encounters")
        pass
    
        
def fetch_tips():
    try:
        # --------------------- TIP ---------------------
        api_tip = make_request(base_url + "/api/tips")
        for tip in api_tip:
            try:
                update_progress_bar(str(api_tip.index(tip)), str(len(api_tip)), "tip")

                tip = {**tip, "tip_id": str(tip["id"])}
                if not db["tip"].find_one(tip):
                    db["tip"].insert_one(tip)
            except Exception as e:
                treat_errors(e, base_url + "/api/tips/" + str(tip["id"]))
                continue
    except Exception as e:
        treat_errors(e, base_url + "/api/tips")
        pass
    

def fetch_events():
    try:
        # --------------------- EVENT ---------------------
        api_event = make_request(base_url + "/api/events")
        for event in api_event:
            try:
                update_progress_bar(str(api_event.index(event)), str(len(api_event)), "event")
                
                if store_small_data["events"]:
                    event = {**event, "small_event_id": str(event["id"]), "event_id": str(event["id"])}
                    if not db["small_event"].find_one(event):
                        db["small_event"].insert_one(event)
                
                full_event = make_request(base_url + "/api/events/" + str(event["id"]))
                full_event = {**full_event, "event_id": str(event["id"])}
                if not db["event"].find_one(full_event):
                    db["event"].insert_one(full_event)

                if db["employee"].find_one({"employee_id": str(full_event["employee_id"])}):
                    db["employee"].update_one({"employee_id": str(full_event["employee_id"])}, {"$addToSet": {"events": full_event}})

            except Exception as e:
                treat_errors(e, base_url + "/api/events/" + str(event["id"]))
                continue
    except Exception as e:
        treat_errors(e, base_url + "/api/events")
        pass
    
        
def fetch_all(employee=True, customers=True, encounters=True, tips=True, events=True):
    threads = []
    if employee:
        threads.append(threading.Thread(target=fetch_employee))
    if customers:
        threads.append(threading.Thread(target=fetch_customers))
    if encounters:
        threads.append(threading.Thread(target=fetch_encounters))
    if tips:
        threads.append(threading.Thread(target=fetch_tips))
    if events:
        threads.append(threading.Thread(target=fetch_events))
    # Start each thread
    for thread in threads:
        thread.start()

    # Wait for all threads to complete
    for thread in threads:
        thread.join()

    clear_screen()

try :
    fetch_all(False, False, False, False, True)
    print_errors_summary()
    print("Script finished")
except Exception as e:
    treat_errors(e, "fetch_all")
    pass
except KeyboardInterrupt as e:
    clear_screen()
    print("Script Stopped")
    print_errors_summary()
