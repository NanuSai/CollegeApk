import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Icon customIcon = Icon(Icons.search);
  Widget customTitle = Text("Main Page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customTitle,
        backgroundColor: Colors.deepOrange,
//         leading: IconButton(
//           tooltip: "Menu",
//           icon: Icon(Icons.menu),
//           onPressed: () {
//             //Leading are the things before title
//             print("Menu");
//           },
//         ),
        actions: <Widget>[
          IconButton(
            icon: customIcon,
            tooltip: "Search..",
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
                        border: InputBorder.none, hintText: "Search term..."),
                  );
                } else {
                  this.customIcon = Icon(Icons.search);
                  this.customTitle = Text("Main Page");
                }
              });
            },
          ),
          IconButton(
            tooltip: "Settings..",
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
        child: Column(
          children: <Widget>[
            _widgetOptions[_selectedIndex],
            RaisedButton(
              child: Text("Back to login page"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text("College")),
          BottomNavigationBarItem(
              icon: Icon(Icons.language), title: Text("Language"))
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.deepOrange
              ),
              child: Text(
                "Main menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text("Message"),
              onTap: () {
                Navigator.pop((context));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop((context));
              },
            ),
          ],
        ),
      ),
    );
  }
}



