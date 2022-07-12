import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import 'product_featured_images.dart';

class ProductDetailsBody extends StatelessWidget {
  final Product product;
  const ProductDetailsBody({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.only(bottom: 100),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          product.isNew
                              ? 'Yangi'
                              : '${product.discount}% CHEGIRMA',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: product.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    Consumer<Products>(
                      builder: (ctx, products, child) {
                        return IconButton(
                          onPressed: () => products.toggleFavorite(product.id),
                          icon: Icon(
                            products.isFavorite(product.id)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 20),
                ProductFeaturedImages(images: product.images.skip(1).toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
