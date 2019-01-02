import 'package:flutter/material.dart';
import 'package:showcase_app/config/screens.dart';
import 'package:showcase_app/widgets/bottom_navigation.dart';
import 'package:showcase_app/widgets/bottom_navigation_button.dart';

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
  int _currentPageIndex = 0;
  PageController pageController;

  List<String> keys;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _currentPageIndex);

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
      onPageChanged: (int newPageIndex) {
        setState(() {
          _currentPageIndex = newPageIndex;
        });
      },
      controller: pageController,
      children: <Widget>[
        AboutPage(
          key: Key(PAGES.about),
        ),
        StorePage(
          key: Key(PAGES.store),
        ),
        DiscoverPage(
          key: Key(PAGES.discover),
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
              // onPressed: (id) {
              //   jumpToPage(id);
              // },
              currentIndex: _currentPageIndex,
              onTap: (int index) {
                setState(() {
                  _currentPageIndex = index;
                  jumpToPage(index);
                });
              },
              items: [
                new BottomNavigationButton(
                  label: 'about.',
                ),
                new BottomNavigationButton(
                  label: 'store.',
                ),
                new BottomNavigationButton(
                  label: 'discover.',
                ),
                new BottomNavigationButton(
                  label: 'story.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
