import 'dart:async';

class CounterBloc {
  int _counter = 0;

  StreamController _counterController = new StreamController<int>.broadcast();

  var _counterTransformer =
      StreamTransformer<int, int>.fromHandlers(handleData: (data, sink) {
    data *= 10;
    sink.add(data);
  });

  Stream get counterStream =>
      _counterController.stream.transform(_counterTransformer);

  incrementCounter() {
    _counter++;
    _counterController.sink.add(_counter);
  }

  void dispose() {
    _counterController.close();
  }
}
