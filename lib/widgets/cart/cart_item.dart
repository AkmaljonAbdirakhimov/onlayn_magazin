import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../models/product.dart';

class CartItem extends StatelessWidget {
  final String cartId;
  final String productId;
  final int quantity;
  const CartItem({
    Key? key,
    required this.cartId,
    required this.productId,
    required this.quantity,
  }) : super(key: key);

  void _increaseItem(BuildContext context) {
    Provider.of<CartItems>(context, listen: false)
        .addToCart(productId: productId);
  }

  void _decreaseItem(BuildContext context) {
    if (quantity > 1) {
      Provider.of<CartItems>(context, listen: false).removeFromCart(productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _product =
        Provider.of<Products>(context, listen: false).getById(productId);

    return ListTile(
      leading: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _product.color.withOpacity(0.4),
              _product.color.withOpacity(0.7),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _product.images[0].startsWith('http')
            ? Image.network(
                _product.images[0],
                width: 40,
                height: 40,
              )
            : Image.asset(
                _product.images[0],
                width: 40,
                height: 40,
              ),
      ),
      title: Text(
        _product.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        '\$ ${(_product.price * quantity).toStringAsFixed(2)}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            splashRadius: 20,
            onPressed: () => _decreaseItem(context),
            icon: const Icon(Icons.remove, color: Colors.black),
          ),
          Container(
            alignment: Alignment.center,
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () => _increaseItem(context),
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
