import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';
import '../../models/product.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    List<Product> _products = Provider.of<Products>(context).favorites;
    return _products.isNotEmpty
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: deviceWidth > 700 ? 2 : 1,
            ),
            padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
            itemCount: _products.length,
            itemBuilder: (_, index) {
              return ChangeNotifierProvider<Product>.value(
                value: _products[index],
                child: const ProductItem(),
              );
            },
          )
        : const Center(
            child: Text('Mahsulotga 🖤 bosing!'),
          );
  }
}
