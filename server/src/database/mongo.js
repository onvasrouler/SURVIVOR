const mongoose = require("mongoose");

const MongoDBURI = process.env.MONGO_URI || "mongodb://127.0.0.1:27017/mydb";

mongoose.set("strictQuery", false);

mongoose.connect(MongoDBURI, {
    dbName: process.env.MONGO_DB_NAME,
    useUnifiedTopology: true,
});

const db = mongoose.connection;
console.log("connecting to the database on " + MongoDBURI);

db.on("error", console.error.bind(console, "connection error:"));

db.once("open", async () => {
    console.log("connexion avec la base de données établie");
});

exports.database = db;