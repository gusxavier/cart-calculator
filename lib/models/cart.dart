import 'dart:collection';

import 'package:cart_calc/entities/cart_item.dart';
import 'package:flutter/foundation.dart';

class CartModel with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  UnmodifiableListView<CartItem> get cartItems =>
      UnmodifiableListView(_cartItems);

  void addItem(CartItem cartItem) {
    _cartItems.add(cartItem);
    notifyListeners();
  }
}
