import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'User.dart';

Future<bool> checkUser(String url, Map body) async {
//  print("Data to send: " + json.encode(body));
  http.Response res = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: json.encode(body));
  print("Response from server" + res.body);
  return res.body == "true" ? true : false;
}

class LoginPage extends StatelessWidget {
  final Future<User> post;
  LoginPage({Key key, this.post}) : super(key: key);

  final String serverUrl =
      'http://192.168.122.1:3000/login';
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      obscureText: false,
      style: style,
      controller: usernameController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "username",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final registerRouteButton = RaisedButton(
      child: Text("Not registered? Register"),
      onPressed: () {
        Navigator.pop(context); //TODO: Popping our context, see if it works.
        Navigator.pushNamed(context, '/register');
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Login User'),
        ),
        body: new Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: new ListView(
            children: <Widget>[
              SizedBox(
                height: 155.0,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 45.0),
              usernameField,
              SizedBox(height: 25.0),
              passwordField,
              SizedBox(
                height: 35.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {
                        User newUser = User(
                            username: usernameController.text,
                            password: passwordController.text);
                        Future<bool> loginResponse = checkUser(
                            serverUrl, newUser.toMap());
                        await loginResponse.then((isUser) {
                          print(isUser);
                          if (isUser)
                            Navigator.pushNamed(context, '/home',
                                arguments: usernameController.text);
                        });
                      },
                      child: Text("login",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ), registerRouteButton
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }
}
