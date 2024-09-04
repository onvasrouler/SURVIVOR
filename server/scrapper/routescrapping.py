import requests
import pymongo
import json
from routescrapping import *
from dotenv import dotenv_values
from schemas import dataSchemas

class Scrapper:
    config = dotenv_values(".env")
    routes = {}
    base_url = config['BASE_URL']
    API_KEY = config['API_KEY']
    JWTBearer = ""
    isLogged = False
    parentSchema = dataSchemas()
    Credentials = parentSchema.Credentials(email=config['MAIL'], password=config['PASSWORD'])

    def __init__(self):
        with open('./scrapper/routes.json') as f:
            self.routes = json.load(f)
        self.login()
        
        
    def login(self):
        url = self.base_url + "api/employees/login"
        headers = {'X-Group-Authorization': self.API_KEY}
        data = self.Credentials.get_all_data()
        response = requests.post(url, headers=headers, json=data)
        if response.status_code == 200:
            self.JWTBearer = response.json()['access_token']
            self.isLogged = True
            print("Login successful")
        else:
            print("Login failed")
    
    def Scrap(self):
        if not self.isLogged:
            print("Not logged in")
            return
        # for routes in self.routes:
        #     for subroutes in self.routes[routes]:
        #         subroutesData = self.routes[routes][subroutes]
        #         subroutesUrl = self.base_url + "api/"+ routes + subroutesData["url"]
        #         print("requesting : " + subroutesUrl)
                #self.treatRoute(subroutesData, subroutesUrl)
                
    def treatRoute(self, routeData, routeUrl):
        if routeData["method"] == "GET":
            response = self.get_request(routeUrl)
            print(response.text)
        elif routeData["method"] == "POST":
            print("skipping login")
        else:
            print("Method not implemented")
    
    def get_request(self, url):
        headers = {'X-Group-Authorization': self.API_KEY}
        headers['Authorization'] = f'Bearer {self.JWTBearer}'
        response = requests.get(url, headers=headers)
        return response
