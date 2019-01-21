import 'package:flutter/material.dart';
import 'package:planets/model/Planet.dart';
import 'package:planets/ui/home/DetailPage.dart';
import 'package:planets/Theme.dart';

class PlanetSummary extends StatelessWidget {
  final Planet planet;
  final bool expanded;

  PlanetSummary(this.planet, {this.expanded = false});

  PlanetSummary.expand(this.planet) : expanded = true;

  @override
  Widget build(BuildContext context) {
    Widget _planetValue({String value, IconData iconData}) {
      return new Row(
        children: <Widget>[
          Icon(
            iconData,
            color: Color(0xFFB6B2DF),
            size: 12.0,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            value,
            style: Style.regularTextStyle,
          ),
        ],
      );
    }

    ;

    final planetThumbnail = new Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      alignment:
          expanded ? FractionalOffset.center : FractionalOffset.centerLeft,
      child: Hero(
        tag: "planet-hero-${planet.id}",
        child: new Image(
          image: new AssetImage(planet.imageUrl),
          height: expanded ? 184.0 : 92.0,
          width: expanded ? 184.0 : 92.00,
        ),
      ),
    );

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(
          !expanded ? 76.0 : 16.0, !expanded ? 16.0 : 76.0, 16.0, 16.0),

      ///We have to define a constraint (BoxConstraints.expand()),
      ///otherwise, the container will adjust to the minimum size required by its children, and we want it to get the whole row.
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment:
            expanded ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 4.0,
          ),
          Text(
            planet.name,
            style: Style.headerTextStyle,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            planet.location,
            style: Style.subHeaderTextStyle,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            decoration: BoxDecoration(
              color: Color(0xFF10A6DD),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                flex: expanded ? 0 : 1,
                child: _planetValue(
                    value: planet.distance, iconData: Icons.my_location),
              ),
              new SizedBox(
                width: 32.0,
              ),
              new Expanded(
                  flex: expanded ? 0 : 1,
                  child: _planetValue(
                      value: planet.gravity, iconData: Icons.arrow_downward)),
            ],
          )
        ],
      ),
    );

    final planetCard = new Container(
      height: expanded ? 200.0 : 124.0,
      margin: expanded
          ? const EdgeInsets.only(top: 124.0)
          : const EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: Color(0xFF434273),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: planetCardContent,
    );

    return GestureDetector(
      onTap: !expanded
          ? () => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new DetailPage(planet),
                transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) =>
                    new SlideTransition(
                      position: new Tween<Offset>(
                              begin: const Offset(-1.0, 0.0), end: Offset.zero)
                          .animate(CurvedAnimation(
                              parent: animation,
                              curve: Interval(0.0, 1.0,
                                  curve: Curves.fastOutSlowIn))),
                      child: child,
                    ),
              ))
          : null,
      child: new Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ),
      ),
    );
  }
}
