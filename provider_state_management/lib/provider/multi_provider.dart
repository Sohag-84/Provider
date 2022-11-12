import 'package:flutter/foundation.dart';

class MultiPoviderClass with ChangeNotifier {
  double _value = 0;
  double get value => _value;

  void setValue(val) {
    _value = val;
    notifyListeners();
  }
}
