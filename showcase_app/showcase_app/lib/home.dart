import 'package:flutter/material.dart';
import 'package:showcase_app/config/screens.dart';
import 'package:showcase_app/widgets/bottom_navigation.dart';

// pages
import 'pages/about.dart';
import 'pages/discover.dart';
import 'pages/store.dart';
import 'pages/story.dart';

// 4 pages: About, Store, Discover, Story
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;

  List<String> keys;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    keys = [
      PAGES.about,
      PAGES.store,
      PAGES.discover,
      PAGES.story,
    ];
  }

  void jumpToPage(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = PageView(
      controller: pageController,
      children: <Widget>[
        AboutPage(
          key: Key(PAGES.about),
        ),
        DiscoverPage(
          key: Key(PAGES.discover),
        ),
        StorePage(
          key: Key(PAGES.store),
        ),
        StoryPage(
          key: Key(PAGES.story),
        )
      ],
    );
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.expand,
        children: <Widget>[
          content,
          Positioned(
            bottom: 0,
            child: BottomNavigation(
              onPressed: (id) {
                jumpToPage(id);
              }
            ),
          ),
        ],
      ),
    );
  }
}
