import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // => for using @required keyword
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Managing State'),
    );
  }
}

// TapboxA manages its own state
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);
  @override
  _TapboxA createState() => new _TapboxA();
}

class _TapboxA extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration:
            BoxDecoration(color: _active ? Colors.green[500] : Colors.grey),
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Tapbox wrapper manages TapboxB class
class TapboxBWrapper extends StatefulWidget {
  _TapboxBWrapperState createState() => _TapboxBWrapperState();
}

class _TapboxBWrapperState extends State<TapboxBWrapper> {
  bool _active = false;

  void _handleTapChange(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TapboxB(active: _active, onChange: _handleTapChange),
      ),
    );
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active = false, @required this.onChange})
      : super(key: key);
  final bool active;
  final ValueChanged<bool> onChange;
  void _handleTap() {
    onChange(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration:
            BoxDecoration(color: active ? Colors.blue[500] : Colors.grey),
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// mix and match approach
// TapboxCWrapper manages TapboxC, holds 'active' state
class TapboxCWrapper extends StatefulWidget {
  _TapboxCWrapperState createState() => _TapboxCWrapperState();
}

class _TapboxCWrapperState extends State<TapboxCWrapper> {
  bool _active = false;

    void handleTapChange(bool newValue) {
      setState(() {
        _active = newValue;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TapboxC(
      active: _active,
      onChanged: handleTapChange,
    ));
  }
}

// TapboxC manages _hightlight state
class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active = false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails tapDownDetails) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails tapUpDetails) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            color: widget.active ? Colors.amber[500] : Colors.grey,
            border: _highlight
                ? Border.all(
                    color: Colors.teal[700],
                    width: 5.0,
                  )
                : null),
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// motherclass
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[TapboxA(), TapboxBWrapper(), TapboxCWrapper()],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
