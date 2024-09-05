const mongoose = require("mongoose");

const MongoDBURI = process.env.MONGO_URI || "mongodb://127.0.0.1:27017/mydb";

const mainDB = mongoose.createConnection(MongoDBURI, {
    dbName: "main_db"
});
const soulConnection = mongoose.createConnection(MongoDBURI, {
    dbName: "soul_connection"
});

mainDB.on("error", (error) => {
    console.error("Main DB connection error:", error);
});

mainDB.once("open", () => {
    console.log("Main DB connected.");
})

soulConnection.on("error", (error) => {
    console.error("Soul Connection DB connection error:", error);
})

soulConnection.once("open", () => {
    console.log("Soul Connection DB connected.");
})

module.exports = { mainDB, soulConnection };
