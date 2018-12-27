import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _ContactCategory extends StatelessWidget {
  _ContactCategory({Key key, this.icon, this.children}) : super(key: key);

  final IconData icon;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: DefaultTextStyle(
          style: themeData.textTheme.subhead,
          child: SafeArea(
            top: false,
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  width: 72.0,
                  child: Icon(icon, color: themeData.primaryColor),
                ),
                Expanded(
                  child: Column(
                    children: children,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class _ContactItem extends StatelessWidget {
  _ContactItem({Key key, this.icon, this.lines, this.tooltip, this.onPress})
      : assert(lines.length > 1),
        super(key: key);

  final IconData icon;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> columnChildren = lines
        .sublist(0, lines.length - 1)
        .map<Widget>((String line) => Text(line))
        .toList();
    columnChildren.add(Text(lines.last, style: themeData.textTheme.caption));

    final List<Widget> rowChildren = <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnChildren,
        ),
      )
    ];

    if (icon != null) {
      rowChildren.add(SizedBox(
        width: 72.0,
        child: IconButton(
          icon: Icon(icon),
          color: themeData.primaryColor,
          onPressed: onPress,
        ),
      ));
    }

    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      ),
    );
  }
}

class ContactDemo extends StatefulWidget {
  @override
  _ContactDemoState createState() => new _ContactDemoState();
}

enum AppBarBehavior { pinned, normal, snapping, floating }

class _ContactDemoState extends State<ContactDemo> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;

  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: _appBarBehavior == AppBarBehavior.pinned,
              snap: _appBarBehavior == AppBarBehavior.snapping,
              floating: _appBarBehavior == AppBarBehavior.floating ||
                  _appBarBehavior == AppBarBehavior.snapping,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.create),
                  tooltip: 'create',
                ),
                PopupMenuButton<AppBarBehavior>(
                  onSelected: (AppBarBehavior value) {
                    setState(() {
                      _appBarBehavior = value;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<AppBarBehavior>>[
                        const PopupMenuItem<AppBarBehavior>(
                          child: Text('App Bar scroll away'),
                          value: AppBarBehavior.normal,
                        ),
                        const PopupMenuItem<AppBarBehavior>(
                          child: Text('App Bar pinned'),
                          value: AppBarBehavior.pinned,
                        ),
                        const PopupMenuItem<AppBarBehavior>(
                          child: Text('App Bar floating'),
                          value: AppBarBehavior.floating,
                        ),
                        const PopupMenuItem<AppBarBehavior>(
                          child: Text('App Bar snaping'),
                          value: AppBarBehavior.snapping,
                        ),
                      ],
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Ali Connors'),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'images/banner.jpg',
                      fit: BoxFit.cover,
                      height: _appBarHeight,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, -0.4),
                            colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      )),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.dark,
                  child: _ContactCategory(
                    icon: Icons.call,
                    children: <Widget>[
                      _ContactItem(
                        icon: Icons.message,
                        tooltip: 'send message',
                        lines: <String>['0123456789', 'Mobile'],
                        onPress: () {
                          _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: Text('sending message'),
                          ));
                        },
                      ),
                      _ContactItem(
                        icon: Icons.message,
                        tooltip: 'send message',
                        lines: <String>['0151255252', 'Work'],
                        onPress: () {
                          _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: Text('sending message'),
                          ));
                        },
                      )
                    ],
                  ),
                ),
                _ContactCategory(
                  icon: Icons.contact_mail,
                  children: <Widget>[
                    _ContactItem(
                      icon: Icons.mail,
                      tooltip: 'send email',
                      lines: <String>['0123456789', 'Mobile'],
                      onPress: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: Text('sending email'),
                        ));
                      },
                    ),
                    _ContactItem(
                      icon: Icons.mail,
                      tooltip: 'send email',
                      lines: <String>['0151255252', 'Work'],
                      onPress: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: Text('sending email'),
                        ));
                      },
                    ),
                    _ContactItem(
                      icon: Icons.mail,
                      tooltip: 'send email',
                      lines: <String>['0151255252', 'Work'],
                      onPress: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: Text('sending email'),
                        ));
                      },
                    ),
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
