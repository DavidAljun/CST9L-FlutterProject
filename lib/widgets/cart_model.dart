// cart_model.dart
import 'package:flutter/foundation.dart';

class CartItem {
  final String itemType;
  final int itemQuantity;
  final double price;

  CartItem({
    required this.itemType,
    required this.itemQuantity,
    required this.price,
  });

  double get total => itemQuantity * price;
}

class CartModel extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class OrderModel {
  final String itemType;
  final int itemQuantity;
  final double total;

  OrderModel({
    required this.itemType,
    required this.itemQuantity,
    required this.total,
  });
}
