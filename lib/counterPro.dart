import 'package:flutter/foundation.dart';

class CounterProvider extends ChangeNotifier {
  int _conter = 0;
  int get counter => _conter;

  void increment() {
    _conter++;
    notifyListeners();
  }

  void decrement() {
    if (_conter >= 1) {
      _conter--;
      notifyListeners();
    }
  }
}
