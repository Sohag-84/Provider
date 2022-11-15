import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/controller/db_helper.dart';
import 'package:shopping_cart/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  int _countItem = 0;
  DbHelper dbHelper = DbHelper();

  int get countItem => _countItem;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<CartModel>> _cart;
  Future<List<CartModel>> getData() async {
    _cart = dbHelper.getCartList();
    return _cart;
  }

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
