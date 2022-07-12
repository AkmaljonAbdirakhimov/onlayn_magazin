import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';

class ProductDetialsFooter extends StatelessWidget {
  final String productId;
  final Color color;
  final double price;
  const ProductDetialsFooter({
    Key? key,
    required this.productId,
    required this.color,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItems>(context);
    return BottomAppBar(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total price:',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$ ${price.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: color),
                )
              ],
            ),
            // if (cart.getById(productId) != null)
            //   ElevatedButton.icon(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.shopping_bag_outlined,
            //       size: 16,
            //     ),
            //     label: const Text(
            //       'Go to cart',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       elevation: 0,
            //       primary: Colors.grey.shade200,
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //   ),
            // if (cart.getById(productId) == null)
            //   ElevatedButton(
            //     onPressed: () {},
            //     child: Text(
            //       'Add to cart',
            //       style: Theme.of(context).textTheme.headline3!.copyWith(
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //           ),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.black,
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
