const express = require('express');
var bodyParser = require('body-parser');
var MongoClient = require('mongodb').MongoClient;
const app = express();
const PORT = process.env.NODE_ENV || 3000;
const SERVER_URL = "mongodb+srv://root:2L9K0KZXS6@cluster0-eo3pl.mongodb.net/test?retryWrites=true&w=majority"; //Connected to online server
const { parse } = require('querystring');


app.use(bodyParser.json());

function insertDocument(username,password){

MongoClient.connect(SERVER_URL,(err,db)=>{

        if (err) throw err;
        console.log("Connected to database! ");
        var dbo = db.db("Users");
        var myobj = {username:username,password:password};
        dbo.collection("login_info").insertOne(myobj,(err,res)=>{
            if (err) throw err;
            console.log("One document inserted!");
            db.close();  
            
        })
})
}

function isDocument(username,password){

        MongoClient.connect(SERVER_URL,(err,db) => {

            if (err) throw err;
            console.log("Connected to database!");
            var dbo = db.db("Users");
            dbo.collection("login_info").findOne({},{projection : {username : username,password:password}},(err,res)=>{
                if(err) throw err;
                console.log("Document found!");
                return true;
            }
        )
})
}



app.get('/',(req,res)=>{
   res.send("Welcome to the Oasis! Hosted by Nanubala Gnana Sai");
   
});

app.post('/login',(req,res)=>{
    
    var username = req.body.username;
    var password = req.body.password;
    console.log(username);
    console.log(password);
    insertDocument(username,password);

});





app.listen(PORT);
console.log(`Listening on http://localhost:${PORT}`);
