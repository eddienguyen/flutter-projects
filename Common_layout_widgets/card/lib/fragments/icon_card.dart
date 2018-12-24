import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var card = SizedBox(
      height: 210,
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('1625 Main Street'),
              subtitle: Text('My City, CA 99984'),
              leading: Icon(Icons.restaurant_menu, color: Colors.blue[500]),
            ),
            Divider(),
            ListTile(
              title: Text('(408) 555-1212'),
              leading: Icon(Icons.contact_phone, color: Colors.blue[500]),
            ),
            ListTile(
              title: Text('costa@example.com'),
              leading: Icon(Icons.contact_mail, color: Colors.blue[500]),
            ),
          ],
        ),
      ),
    );
    return card;
  }
}
