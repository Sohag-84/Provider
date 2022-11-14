import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  int _countItem = 0;
  int get countItem => _countItem;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  //shared preference for store cart item
  void _setPrefItems() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("cart_item", _countItem);
    preferences.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _countItem = preferences.getInt('cart_item') ?? 0;
    _totalPrice = preferences.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _countItem++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _countItem--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _countItem;
  }

  //for total price
  void addTotalPrice({required double productPrice}) {
    _totalPrice += productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice({required double productPrice}) {
    _totalPrice -= productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
