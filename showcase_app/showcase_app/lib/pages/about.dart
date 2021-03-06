import 'package:flutter/material.dart';
import 'package:showcase_app/widgets/about_header.dart';
import 'package:showcase_app/widgets/carousel_image_slider.dart';
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

    drawer = DrawerPanel(
        shouldShow: isShowPanel,
        onHideCompleted: () {
          hideDrawerPanel();
        });

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
                    delegate: SliverChildListDelegate([
                  Container(
                    height: 200,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CarouselImageSlider(
                      list: imageUrls,
                      hasIndicator: true,
                    ),
                  ),
                ])),
              ],
            ),
          ),
        ),
        drawer,
      ],
    );
  }
}
