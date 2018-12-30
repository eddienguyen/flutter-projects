import 'package:flutter/material.dart';

class ContactCircleAvatar extends StatefulWidget {
  @override
  _ContactCircleAvatarState createState() => new _ContactCircleAvatarState();
}

class _ContactCircleAvatarState extends State<ContactCircleAvatar> {
  @override
  Widget build(BuildContext context) {
    var stack = Stack(
      alignment: const Alignment(0.5, 0.5),
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage('images/testimonials_4.jpg'),
          radius: 100.0,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black45),
          child: Text(
            'Lorem ipsum',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
          ),
        )
      ],
    );

    return Center(
      child: stack,
    );
  }
}
