from pymongo import MongoClient
from dotenv import dotenv_values
from fastapi import FastAPI, HTTPException, Response
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
import sys
sys.path.append('./scrapper')
from routescrapping import *

config = dotenv_values(".env")
DB = ""

app = FastAPI()

@app.get("/scrapeall")
def trigger_scrape():
    JSONResponse(content={"message": "Starting to scrapp..."}, status_code=200)
    print("Scraping all")


def connect_mongodb():
    client = MongoClient(config['MONGO_URI'])
    DB = client[config['MONGO_DB_NAME']]
    print("Connected to MongoDB")

if __name__ == "__main__":
    import uvicorn
    connect_mongodb()
    scrapper = Scrapper()
    scrapper.Scrap()
    uvicorn.run(app, host="127.0.0.1", port=int(config['PYTHON_PORT']))
    
