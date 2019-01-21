import 'package:flutter/material.dart';
import 'package:planets/model/Planet.dart';
import 'package:planets/ui/home/PlanetSummary.dart';
import 'package:planets/Theme.dart';

class DetailPage extends StatelessWidget {
  final Planet planet;

  DetailPage(this.planet);

  @override
  Widget build(BuildContext context) {
    Container _getBackground() {
      return new Container(
        constraints: BoxConstraints.expand(height: 300.0),
        child: new Image.network(
          planet.backgroundImageUrl,
          height: 300.0,
          fit: BoxFit.cover,
        ),
      );
    }

    Container _getGradient() {
      return new Container(
        height: 110.0,
        margin: EdgeInsets.only(top: 190.0),
        decoration: BoxDecoration(
            gradient: new LinearGradient(
          colors: <Color>[
            new Color(0x00736AB7),
            new Color(0xFF736AB7),
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        )),
      );
    }

    Widget _getContent() {
      return ListView(
        padding: const EdgeInsets.fromLTRB(0, 72.0, 0.0, 32.0),
        children: <Widget>[
          PlanetSummary.expand(planet),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Overview'.toUpperCase(),
                  style: Style.titleTextStyle,
                ),
                Text(
                  planet.description,
                  style: Style.commonTextStyle,
                )
              ],
            ),
          ),
        ],
      );
    }

    Container _getToolbar() {
      return Container(
        margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new BackButton(
          color: Colors.white,
        ),
      );
    }

    return Scaffold(
      body: new Container(
        constraints: BoxConstraints.expand(),
        color: new Color(0xFF736AB7),
        child: Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(),
          ],
        ),
      ),
    );
  }
}
