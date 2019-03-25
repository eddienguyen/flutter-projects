import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_counter/models/counter_model.dart';

void main() {
  final counter = CounterModel();
  runApp(ScopedModel<CounterModel>(
    model: counter,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScopedModel Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter counter Home '),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    // final counter = ScopedModel.of<CounterModel>(context).counter;
    final username =
        ScopedModel.of<CounterModel>(context, rebuildOnChange: true).username;

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$username have pushed the button this many times:',
            ),
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) {
                return Text(
                  '${model.counter}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: _IncrementButton(),
    );
  }
}

class _IncrementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => ScopedModel.of<CounterModel>(context).increment(),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
