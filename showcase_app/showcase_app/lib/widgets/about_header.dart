import 'package:flutter/material.dart';

class AboutHeader extends StatefulWidget {
  @override
  _AboutHeaderState createState() => _AboutHeaderState();
}

class _AboutHeaderState extends State<AboutHeader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      
      child: Container(
          height: 80,
          color: Colors.black45,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: new Text(
                'AboutHeader',
                style: Theme.of(context).textTheme.title,
              )),
            ],
          )),
    );
  }
}
