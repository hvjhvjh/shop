import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, Object>> _cart = [];

  List<Map<String, Object>> get cart => _cart;

  void addProduct(Map<String, Object> product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeProduct(Map<String, Object> product) {
    _cart.remove(product);
    notifyListeners();
  }
}
