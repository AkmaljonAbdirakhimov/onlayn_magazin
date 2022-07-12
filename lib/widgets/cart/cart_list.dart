import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_item.dart';
import '../../models/cart.dart';

class CartList extends StatelessWidget {
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 20,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          child: Text(
            'Sizning buyurtmalaringiz',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount:
                Provider.of<CartItems>(context, listen: false).totalItems(),
            itemBuilder: (_, i) {
              return Consumer<CartItems>(
                builder: (_, cart, child) => CartItem(
                  cartId: cart.list.values.toList()[i].id,
                  quantity: cart.list.values.toList()[i].quantity,
                  productId: cart.list.keys.toList()[i],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
