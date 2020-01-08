import 'package:flutter/material.dart';

import 'User.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

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
    Text(
      'Index 3: Unknown',
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
    // Pass User object to constructor instead.
    final User args = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
      appBar: AppBar(
        title: customTitle,
        backgroundColor: Colors.deepOrange,
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
              child: Text("Back to User page"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black38,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.deepOrange,
            ),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
                color: Colors.black38,
              ),
              activeIcon: Icon(
                Icons.school,
                color: Colors.deepOrange,
              ),
              title: Text("College")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.language,
                color: Colors.black38,
              ),
              activeIcon: Icon(
                Icons.language,
                color: Colors.deepOrange,
              ),
              title: Text("Language")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: Colors.black38,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                color: Colors.deepOrange,
              ),
              title: Text("Your Account")),
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
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Text(
                "\n\n" + (args != null ? args.username : "Anonymous"),
                // Check not provided if no User object provided.
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
                // Navigator.pop((context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
