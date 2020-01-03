import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  Column _buildButtonColumn(IconData icon, Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton.icon(onPressed: () => launch("tel:07306473364"),
            icon: Icon(icon, color: color, size: 30,),
            label: Text(label)), //Adding call system (For now to all)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    final Widget titleSection = Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //Lets see
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Indian Institue of Information Technology,Sri City",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Chittoor,Andhra Pradesh, India ",
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('3.7')
        ],
      ),
    );
    final Widget buttonSection = Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(Icons.call, color, 'CALL'),
          _buildButtonColumn(Icons.near_me, color, 'ROUTE'),
          _buildButtonColumn(Icons.share, color, 'SHARE')
        ],
      ),
    );
    final Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        "Indian Institute of Information Technology, Sri City is an educational institute of national importance located in Sri City,"
        " Chittoor District Andhra Pradesh, "
        "India set up by the Ministry of Human Resource Development, Government of India, under the Partnership"
        " with AP government and Sri City consortium",
        softWrap: true,
      ),
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Image.asset(
            "assets/images/college_pic.jpeg",
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          textSection
        ],
      ),
    );
  }
}
