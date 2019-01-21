import 'package:flutter/material.dart';
import 'package:planets/model/Planets.dart';
import 'package:planets/ui/home/PlanetSummary.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Because ListView is not able to calculate its own height (mainly because the HomePagebody Widget is inside a Column).
    /// The solution is wrap ListView inside a Expanded widget
    return Expanded(
      child: Container(
        color: Color(0xFF3E3963),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              sliver: SliverFixedExtentList(
                itemExtent: 152.0,
                delegate: SliverChildBuilderDelegate(
                        (context, index) => new PlanetSummary(planets[index]),
                        childCount: planets.length,
                ),
              ),
            ),
          ],
//        child: ListView.builder(
//          itemBuilder: (context, index) => new PlanetRow(planets[index]),
//          itemExtent: 152.0,
//          itemCount: planets.length,
//          padding: EdgeInsets.symmetric(vertical: 16.0),
//        ),
        ),
      ),
    );
  }
}
