import 'package:flutter/material.dart';
import 'package:showcase_app/widgets/about_header.dart';
import 'package:showcase_app/widgets/drawer_panel.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  bool isSearching = false;
  DrawerPanel drawer;

  @override
  Widget build(BuildContext context) {
    // search
    IconButton searchAction = isSearching
        ? IconButton(
            icon: Icon(Icons.close),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                isSearching = false;
              });
            },
          )
        : IconButton(
            icon: Icon(Icons.search),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
          );

    // menu
    IconButton menuIcon = IconButton(
      icon: Icon(Icons.menu),
      color: Theme.of(context).primaryColor,
      onPressed: () {},
    );

    // SearchField || Logo
    Widget headerTitle = isSearching
        ? TextField(
            style: Theme.of(context).textTheme.body1,
            decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.search, color: Theme.of(context).primaryColor),
                hintText: 'search'),
          )
        : Hero(
            tag: 'logoC2A',
            child: Image.asset(
              'assets/images/logo-c2a.png',
              width: 60,
              height: 60,
            ),
          );

    drawer = DrawerPanel();

    return Stack(
      children: <Widget>[
        SafeArea(
          child: drawer,
        ),
        SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                backgroundColor: Colors.transparent,
                title: headerTitle,
                leading: menuIcon,
                actions: <Widget>[searchAction],
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                  Text('..'),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
