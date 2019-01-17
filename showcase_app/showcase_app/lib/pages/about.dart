import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:showcase_app/widgets/about_header.dart';
import 'package:showcase_app/widgets/drawer_panel.dart';
import 'package:showcase_app/widgets/image_holder.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  bool isSearching = false;
  bool isShowPanel = false;
  Widget drawer;

  List<String> imageUrls = [
    'assets/images/demo/8.jpg',
    'assets/images/demo/9.jpg',
    'assets/images/demo/10.jpg',
  ];

  void showDrawerPanel() {
    if (mounted) {
      setState(() {
        isShowPanel = true;
      });
    }
  }

  void hideDrawerPanel() {
    if (mounted) {
      setState(() {
        isShowPanel = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
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
      onPressed: () {
        showDrawerPanel();
      },
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
        : Center(
            child: Hero(
              tag: 'logoC2A',
              child: Image.asset(
                'assets/images/logo-c2a.png',
                width: 60,
                height: 60,
              ),
            ),
          );

    drawer = DrawerPanel(shouldShow: isShowPanel);

    return Stack(
      children: <Widget>[
        Container(
          child: SafeArea(
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
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
                    // banner
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: new CarouselSlider(
                        items: imageUrls.map((url) {
                          return new Builder(
                            builder: (BuildContext context) {
                              return new Container(
                                width: screenWidth,
//                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorDark),
                                child: new ImageHolder(
                                  url: url,
                                  height: 200.0,
                                ),
                              );
                            },
                          );
                        }).toList(),
                        viewportFraction: 1.0,
                        height: 200.0,
                        autoPlay: true,
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: drawer,
        ),
      ],
    );
  }
}
