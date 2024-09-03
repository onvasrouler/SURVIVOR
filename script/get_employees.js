const axios = require('axios');
const { MongoClient } = require('mongodb');
const fs = require('fs');

async function fetchEmployees() {
  try {
    const response = await axios.get('https://soul-connection.fr/api/employees', {
      headers: {
        'accept': 'application/json',
        'X-Group-Authorization': 'bf0d22904b98ad48a9cbf9251758ce74',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiZW1haWwiOiJqZWFubmUubWFydGluQHNvdWwtY29ubmVjdGlvbi5mciIsIm5hbWUiOiJKZWFubmUiLCJzdXJuYW1lIjoiTWFydGluIiwiZXhwIjoxNzI3MTY2MTQwfQ.HugTXnTMkWuesiXUujLoTiwdJ3VVqqKDGwv2dk76oFo'
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching employees:', error);
    return null;
  }
}

async function storeEmployeesInMongoDB(employees) {
  const uri = 'mongodb://localhost:27017';
  const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

  try {
    await client.connect();
    const database = client.db('soul-connection');
    const collection = database.collection('employees');

    const result = await collection.insertMany(employees);
    console.log(`${result.insertedCount} employees were inserted into the collection.`);
  } catch (error) {
    console.error('Error storing employees in MongoDB:', error);
  } finally {
    await client.close();
  }
}

async function storeEmployeesInJsonFile(employees) {
    const filePath = './employees.json';
    try {
      fs.writeFileSync(filePath, JSON.stringify(employees, null, 2));
      console.log(`Employees data was written to ${filePath}`);
    } catch (error) {
      console.error('Error writing employees to JSON file:', error);
    }
  }

(async function () {
  const employees = await fetchEmployees();
  if (employees) {
    await storeEmployeesInMongoDB(employees);
    storeEmployeesInJsonFile(employees);
  }
})();
