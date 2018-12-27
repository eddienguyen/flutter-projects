import 'package:flutter/material.dart';

final double kColorSemanticsHeight = 48.0;

class ColorItem extends StatelessWidget {
  final int index;
  final String prefix;
  final Color colorData;

  const ColorItem(
      {Key key,
      @required this.index,
      @required this.colorData,
      this.prefix = ''})
      : assert(index != null),
        assert(colorData != null),
        assert(prefix != null),
        super(key: key);

  String colorString() =>
      "#${colorData.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Container(
        height: kColorSemanticsHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: colorData,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text('$prefix$index'), Text(colorString())],
          ),
        ),
      ),
    );
  }
}

class Palette {
  Palette({this.name, this.primary, this.accent, this.threshold = 900});

  final String name;
  final MaterialColor primary;
  final MaterialAccentColor accent;
  final int
      threshold; // titles for indices > threshold are white, otherwise black;
  bool get isValid => name != null && primary != null && threshold != null;
}

final List<Palette> allPalettes = <Palette>[
  Palette(
      name: 'RED',
      primary: Colors.red,
      accent: Colors.redAccent,
      threshold: 300),
  Palette(
      name: 'PINK',
      primary: Colors.pink,
      accent: Colors.pinkAccent,
      threshold: 200),
  Palette(
      name: 'PURPLE',
      primary: Colors.purple,
      accent: Colors.purpleAccent,
      threshold: 200),
  Palette(
      name: 'DEEP PURPLE',
      primary: Colors.deepPurple,
      accent: Colors.deepPurpleAccent,
      threshold: 200),
  Palette(
      name: 'INDIGO',
      primary: Colors.indigo,
      accent: Colors.indigoAccent,
      threshold: 200),
  Palette(
      name: 'BLUE',
      primary: Colors.blue,
      accent: Colors.blueAccent,
      threshold: 400),
  Palette(
      name: 'LIGHT BLUE',
      primary: Colors.lightBlue,
      accent: Colors.lightBlueAccent,
      threshold: 500),
  Palette(
      name: 'CYAN',
      primary: Colors.cyan,
      accent: Colors.cyanAccent,
      threshold: 600),
  Palette(
      name: 'TEAL',
      primary: Colors.teal,
      accent: Colors.tealAccent,
      threshold: 400),
  Palette(
      name: 'GREEN',
      primary: Colors.green,
      accent: Colors.greenAccent,
      threshold: 500),
  Palette(
      name: 'LIGHT GREEN',
      primary: Colors.lightGreen,
      accent: Colors.lightGreenAccent,
      threshold: 600),
  Palette(
      name: 'LIME',
      primary: Colors.lime,
      accent: Colors.limeAccent,
      threshold: 800),
  Palette(name: 'YELLOW', primary: Colors.yellow, accent: Colors.yellowAccent),
  Palette(name: 'AMBER', primary: Colors.amber, accent: Colors.amberAccent),
  Palette(
      name: 'ORANGE',
      primary: Colors.orange,
      accent: Colors.orangeAccent,
      threshold: 700),
  Palette(
      name: 'DEEP ORANGE',
      primary: Colors.deepOrange,
      accent: Colors.deepOrangeAccent,
      threshold: 400),
  Palette(name: 'BROWN', primary: Colors.brown, threshold: 200),
  Palette(name: 'GREY', primary: Colors.grey, threshold: 500),
  Palette(name: 'BLUE GREY', primary: Colors.blueGrey, threshold: 500)
];

class PaletteTabView extends StatelessWidget {
  PaletteTabView({Key key, @required this.colors})
      : assert(colors != null && colors.isValid),
        super(key: key);

  final Palette colors;

  static const List<int> primaryKeys = <int>[
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900
  ];
  static const List<int> accentKeys = <int>[100, 200, 400, 700];

  @override
  Widget build(BuildContext context) {
    final TEXT_THEME = Theme.of(context).textTheme;
    final WHITE_TEXT_STYLE = TEXT_THEME.body1.copyWith(color: Colors.white);
    final BLACK_TEXT_STYLE = TEXT_THEME.body1.copyWith(color: Colors.black);

    final List<Widget> colorItems = primaryKeys.map<Widget>((int index) {
      return DefaultTextStyle(
        style: index > colors.threshold ? WHITE_TEXT_STYLE : BLACK_TEXT_STYLE,
        child: ColorItem(index: index, colorData: colors.primary[index]),
      );
    }).toList();

    if (colors.accent != null) {
      colorItems.addAll(accentKeys.map<Widget>((int index) {
        return DefaultTextStyle(
          style: index > colors.threshold ? WHITE_TEXT_STYLE : BLACK_TEXT_STYLE,
          child: ColorItem(
            index: index,
            colorData: colors.accent[index],
            prefix: 'A',
          ),
        );
      }).toList());
    }

    return ListView(
      itemExtent: kColorSemanticsHeight,
      children: colorItems,
    );
  }
}

class ColorsListFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: allPalettes.length,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0,
          flexibleSpace: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new TabBar(
                isScrollable: true,
                tabs: allPalettes
                    .map<Widget>((Palette swatch) => Tab(text: swatch.name))
                    .toList(),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: allPalettes
              .map<Widget>((Palette colors) => PaletteTabView(colors: colors))
              .toList(),
        ),
      ),
    );
  }
}
