const express = require('express');
var bodyParser = require('body-parser');
var MongoClient = require('mongodb').MongoClient;
const app = express();
const PORT = process.env.NODE_ENV || 3000;
const SERVER_URL = "mongodb+srv://root:2L9K0KZXS6@cluster0-eo3pl.mongodb.net/test?retryWrites=true&w=majority"; //Connected to online server
const {
    parse
} = require('querystring');
const bcrypt = require('bcrypt');


app.use(bodyParser.json());

MongoClient.connect(SERVER_URL, (err, db) => {

    if (err) throw err;
    console.log("Connected to database! ");

    var dbo = db.db("Users");

    function insertDocument(username, password) {

        var myobj = {
            username: username,
            password: password
        };

        dbo.collection("login_info").insertOne(myobj, (err, res) => {
            if (err) throw err;
            console.log("One document inserted!");
        })
    }

    function isDocument(username, password, result) {

        console.log(username);
        console.log(password);

        var query = { //This query only check if username matches
            username: username
        };

        dbo.collection("login_info").findOne(query, async (err, res) => {
            if (err) throw err;


            if (res != null) {
                // Username correct
                console.log("Found: " + res.username);
                try { //Check password 
                    console.log(password); //Password wrong => null returned

                    if ((await bcrypt.compare(password, res.password)) && res.password != null) { //compare your password after hashing to db password
                        result(true);
                        console.log("Document found!");
                    } else { // Send result false to login endpoint
                        console.log("Enter the right password please");
                        result(false);
                    }
                } catch (err) { //Error in bcrypt
                    console.log(err);
                }
            } else { //Username not found in database
                console.log("Account doesn't exist");
                result(false); //Confirmation for register-endpoint
            }
        })

    }


    app.get('/', (req, res) => {
        res.send("Welcome to the Oasis! Hosted by Nanubala Gnana Sai");

    });




    app.listen(PORT);
    console.log(`Listening on http://localhost:${PORT}`);


    app.post('/users/login', async (req, res) => {

        var username = req.body.username;
        var password = req.body.password;


        isDocument(username, password, function (match) {
            if (match) {
                console.log("Welcome user! " + username);
                res.status(200).send("ok");
            } else {
                res.status(404).send("Not found in database!");
            }
        })




    });

    app.post('/users/register', (req, res) => {
        console.log(req.body)
        var username = req.body.username;
        var password = req.body.password;


        isDocument(username, password, async (found) => {

            console.log(found);
            if (!found) {
                try {
                    const salt = await bcrypt.genSalt();
                    const hashedPassword = await bcrypt.hash(password, salt);
                    console.log("Registering!");
                    insertDocument(username, hashedPassword);
                    console.log("Salt generated is" + salt);
                    console.log("Hashed password is: " + hashedPassword);

                    res.status(201).json({
                        "username": username,
                        "password": hashedPassword
                    });
                } catch (err) {
                    console.log(err.body);
                    res.status(500).send(err.body);
                }
            } else {
                res.status(400).send("Already registered!");
            }
        })



    });


})