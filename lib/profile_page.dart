import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  Column _buildButtonColumn(IconData icon, Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: color),
          ),
        )
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
                    "Indian institute of Information Technology,Sri City, Chittooor",
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
          Text('41')
        ],
      ),
    );
    final Widget buttonSection = Container(
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
      body: Column(
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
