import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final List<String> images;
  final bool isNew;
  final int discount;
  final Color color;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.color,
    this.discount = 0,
    this.isNew = false,
  });
}

class Products with ChangeNotifier {
  final List<Product> _list = [
    Product(
      id: 'p1',
      title: 'Santa\'s hat',
      description: 'Fabric, clean, red',
      price: 9.90,
      images: [
        'assets/images/hat.png',
        'assets/images/hat.png',
        'assets/images/hat.png',
        'assets/images/hat.png',
        'assets/images/hat.png'
      ],
      color: Colors.red,
      isNew: true,
    ),
    Product(
      id: 'p2',
      title: 'Gloves',
      description: 'Fabric, clean, blue',
      price: 19.90,
      images: [
        'assets/images/gloves.png',
        'assets/images/gloves.png',
        'assets/images/gloves.png',
        'assets/images/gloves.png',
        'assets/images/gloves.png'
      ],
      color: Colors.blue,
      discount: 20,
    ),
    Product(
      id: 'p3',
      title: 'Game Controller',
      description: 'Smart, white, game',
      price: 29.90,
      images: [
        'assets/images/game-controller.png',
        'assets/images/game-controller.png',
        'assets/images/game-controller.png',
        'assets/images/game-controller.png',
        'assets/images/game-controller.png'
      ],
      color: Colors.cyan,
      discount: 10,
    ),
    Product(
      id: 'p4',
      title: 'Flash T-shirt',
      description: 'Flash, modern, red',
      price: 29.90,
      images: [
        'assets/images/tshirt.png',
        'assets/images/tshirt.png',
        'assets/images/tshirt.png',
        'assets/images/tshirt.png',
        'assets/images/tshirt.png'
      ],
      color: Colors.deepOrangeAccent,
      isNew: true,
    ),
  ];

  List<Product> _favorites = [];

  List<Product> get list {
    return _list;
  }

  List<Product> get favorites {
    return _favorites;
  }

  Product getById(String id) {
    return _list.firstWhere((product) => product.id == id);
  }

  bool isFavorite(String id) {
    return _favorites.any((product) => product.id == id);
  }

  void toggleFavorite(String productId) {
    var index = _favorites.indexWhere((product) => product.id == productId);
    if (index < 0) {
      _favorites.add(_list.firstWhere((product) => product.id == productId));
    } else {
      _favorites.removeAt(index);
    }
    notifyListeners();
  }

  void addProduct(Product product) {
    _list.add(product);
    notifyListeners();
  }

  void editProduct(Product product) {
    var productIndex = _list.indexWhere((pro) => pro.id == product.id);
    if (productIndex != -1) {
      _list[productIndex] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _list.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
