const express = require('express');
var bodyParser = require('body-parser');
var MongoClient = require('mongodb').MongoClient;
const app = express();
const PORT = process.env.NODE_ENV || 3000;
const SERVER_URL = "mongodb+srv://root:2L9K0KZXS6@cluster0-eo3pl.mongodb.net/test?retryWrites=true&w=majority"; //Connected to online server
const { parse } = require('querystring');


app.use(bodyParser.json());


MongoClient.connect(SERVER_URL, (err, db) => {

if (err) throw err;
    console.log("Connected to database! ");

    var dbo = db.db("Users");

    function insertDocument(username,password){
        
        var myobj = {username:username,password:password};

        dbo.collection("login_info").insertOne(myobj, (err, res) => {
            if (err) throw err;
            console.log("One document inserted!");        
        })
    }

    function isDocument(username,password,result){

        console.log(username);
        console.log(password);
        
        
        dbo.collection("login_info").findOne({ projection: { username: username, password: password } }, (err, res) => {
            if (err) throw err;

            console.log(res);
            result(false);  

            if(res != null)
                result(true);

        })  

    }


    app.get('/', (req, res) => {
        res.send("Welcome to the Oasis! Hosted by Nanubala Gnana Sai");

    });




    app.listen(PORT);
    console.log(`Listening on http://localhost:${PORT}`);


    app.post('/login', (req, res) => {
        var username = req.body.username;
        var password = req.body.password;
        isDocument(username,password,function(match){
            if(match == true){
                console.log("Welcome user! " + username);
                res.send(match);
            }
            else{
                console.log("You're not registered!");
                res.send(null);
            }
                

            
        })
    });

    app.post('/register', (req, res) => {
        console.log(req.body)
        var username = req.body.username;
        var password = req.body.password;
    
         
        isDocument(username,password,function(result){

        console.log(result);
        if(!result){
        console.log("Registering!");
        insertDocument(req.body.username, req.body.password);
        res.json({"username":username,"password":password});
        }
        else{
            res.send({"WRONG":"WRONG"});
        }
    })
    
    
       
    });
    
    
})





        
       

  





