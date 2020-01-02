import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Icon customIcon = Icon(Icons.search);
  Widget customTitle = Text("Main Page");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customTitle,
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            //Leading are the things before title
            print("Clicked");
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: customIcon,
            onPressed: () {
              print("Searching");
              setState(() {
                if (this.customIcon.icon == Icons.search) {
                  this.customIcon = Icon(Icons.cancel);
                  this.customTitle = TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,

                    ),
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search term..."
                    ),
                  );
                }
                else {
                  this.customIcon = Icon(Icons.search);
                  this.customTitle = Text("Main Page");
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              print("vertical");
            },
          ),
        ],
        elevation: 14,

        titleSpacing: 12,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
