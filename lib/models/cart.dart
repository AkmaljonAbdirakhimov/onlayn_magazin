import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  final String id;
  final int quantity;
  final double price;

  Cart({
    required this.id,
    required this.quantity,
    required this.price,
  });
}

class CartItems with ChangeNotifier {
  Map<String, Cart> _list = {};

  Map<String, Cart> get list {
    return _list;
  }

  int totalItems() {
    return _list.length;
  }

  double totalPrice() {
    return _list.values.fold(
        0,
        (previousValue, cartItem) =>
            previousValue + cartItem.price * cartItem.quantity);
  }

  Cart? getById(String productId) {
    return _list[productId];
  }

  void addToCart({
    required String productId,
    double? price,
  }) {
    if (_list.containsKey(productId)) {
      _list.update(
        productId,
        (existingCartItem) => Cart(
          id: existingCartItem.id,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _list.putIfAbsent(
        productId,
        () => Cart(
          id: UniqueKey().toString(),
          price: price!,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(String productId, {bool isDeleting = false}) {
    if (_list.containsKey(productId)) {
      if (isDeleting) {
        _list.remove(productId);
      } else {
        _list.update(
          productId,
          (existingCartItem) => Cart(
            id: existingCartItem.id,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
          ),
        );
      }
    }
    notifyListeners();
  }
}
