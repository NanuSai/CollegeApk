import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';

Future<Login> createLogin(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Login.fromJson(json.decode(response.body));
  });
}

class LoginPage extends StatelessWidget {
  final Future<Login> post;

  LoginPage({Key key, this.post}) : super(key: key);
  static final CREATE_POST_URL = 'https://jsonplaceholder.typicode.com/posts';
  final TextEditingController emailControler = new TextEditingController();
  final TextEditingController passwordControler = new TextEditingController();
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: emailControler,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: passwordControler,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final Widget loginButton = new RaisedButton(
      onPressed: () async {
        Login newLogin = new Login(
            email: emailControler.text, password: passwordControler.text);
        Login p = await createLogin(CREATE_POST_URL, body: newLogin.toMap());
        print(p.email);
        Navigator.pushNamed(context, '/home');
      },
      child: Text("Login",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('User Login'),
        ),
        body: new Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 155.0,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 45.0),
              emailField,
              SizedBox(height: 25.0),
              passwordField,
              SizedBox(
                height: 35.0,
              ),
              loginButton,
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }
}
