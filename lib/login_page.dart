import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';

Future<Login> createLogin(String url, Map body) async {
  print("Data to send: " + json.encode(body));
  http.Response res = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: json.encode(body));
  print(res.body);
  return Login.fromJson(json.decode(res.body));
}

class LoginPage extends StatelessWidget {
  final Future<Login> post;

  LoginPage({Key key, this.post}) : super(key: key);
  final String CREATE_POST_URL =
      'http://192.168.122.1:3000/login'; //TODO: Here you insert your IP address from ifconfig/ipconfig
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
    return Scaffold(
        appBar: AppBar(
          title: Text('User Login'),
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
              RaisedButton(
                onPressed: () async {
                  Login newLogin = Login(
                      username: usernameController.text,
                      password: passwordController.text);
                  Future<Login> p = createLogin(
                      CREATE_POST_URL, newLogin.toMap());
                  await p.then((value) {
                    print(value);
                    Navigator.pushNamed(context, '/home', arguments: value);
                  });
                },
                child: Text("Login",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }
}
