import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../models/cart.dart';
import '../../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  void _showProductDetails(BuildContext context, Product product) {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (_) {
        return ProductDetails(product: product);
      },
    );
  }

  void addToCart(BuildContext context, Product product) {
    Provider.of<CartItems>(context, listen: false).addToCart(
      productId: product.id,
      price: product.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => _showProductDetails(context, product),
        splashColor: product.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                product.color.withOpacity(0.4),
                product.color.withOpacity(0.7),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  if (product.images[0].startsWith('http'))
                    Image.network(
                      product.images[0],
                      width: 230,
                      height: 230,
                    ),
                  if (!product.images[0].startsWith('http'))
                    Image.asset(
                      product.images[0],
                      width: 230,
                      height: 230,
                    ),
                  if (product.isNew)
                    Positioned(
                      right: 0,
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 30,
                          child: Text(
                            "Yangi",
                            style: TextStyle(
                              color: product.color,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                    ),
                  if (product.discount > 0)
                    Positioned(
                      left: 0,
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          width: 130,
                          height: 30,
                          child: Text(
                            "${product.discount}% CHEGIRMA",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        color: product.color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                    ),
                ],
              ),
              Text(
                product.title,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: product.color),
              ),
              Text(
                product.description,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                  color: product.color.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$ ${product.price.toStringAsFixed(2)}",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () => addToCart(context, product),
                    child: const Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      primary: Colors.white.withOpacity(0.3),
                      elevation: 0,
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
