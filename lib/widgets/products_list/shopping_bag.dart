import 'package:flutter/material.dart';
import 'package:onlayn_magazin/models/cart.dart';
import 'package:provider/provider.dart';

import '../../screens/cart_screen.dart';

class ShoppingBag extends StatelessWidget {
  final Function()? handler;
  const ShoppingBag({
    Key? key,
    this.handler,
  }) : super(key: key);

  void _gotoCart(BuildContext context) {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => _gotoCart(context),
          icon: const Icon(
            Icons.shopping_bag_outlined,
            size: 26,
          ),
        ),
        Positioned(
          right: 8,
          top: 5,
          child: Container(
            alignment: Alignment.center,
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Consumer<CartItems>(
              builder: (ctx, cart, child) {
                return Text(
                  cart.totalItems().toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
