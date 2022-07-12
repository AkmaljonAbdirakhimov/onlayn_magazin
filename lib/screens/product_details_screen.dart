import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/products_details/product_details_body.dart';
import '../widgets/products_details/product_details_header.dart';
import '../widgets/products_details/product_details_footer.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              product.color.withOpacity(0.4),
              product.color.withOpacity(0.7),
              product.color.withOpacity(0.7),
              product.color.withOpacity(0.7),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            ProductDetailsHeader(productImage: product.images[0]),
            ProductDetailsBody(product: product),
          ],
        ),
      ),
      bottomSheet: ProductDetialsFooter(
        productId: product.id,
        color: product.color,
        price: product.price,
      ),
    );
  }
}
