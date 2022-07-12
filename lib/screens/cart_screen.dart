import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../widgets/cart/cart_footer.dart';
import '../widgets/cart/cart_list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Savatcha',
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Tozalash',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
      body: const CartList(),
      bottomSheet: const CartFooter(),
    );
  }
}
