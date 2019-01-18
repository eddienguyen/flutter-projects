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
    pageController = PageController(
      initialPage: _currentPageIndex,
    );

    keys = [
      PAGES.about,
      PAGES.store,
      PAGES.discover,
      PAGES.story,
    ];
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int newPageIndex) async {
    setState(() {
      _currentPageIndex = newPageIndex;
    });
  }

  void onBottomNavigationTapped(int pageIndex) async {
    await pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    setState(() {
      _currentPageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget content = PageView(
      onPageChanged: onPageChanged,
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
              currentIndex: _currentPageIndex,
              onTap: onBottomNavigationTapped,
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
