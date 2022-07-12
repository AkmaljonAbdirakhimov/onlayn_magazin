import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_drawer.dart';
import '../models/product.dart';
import 'add_edit_product_screen.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/manage-products';

  void _gotoAddProductScreen(BuildContext context, {String? productId}) {
    Navigator.of(context).pushNamed(
      AddEditScreen.routeName,
      arguments: productId,
    );
  }

  void _notifyUserAboutDelete(
      BuildContext context, String title, String productId) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Ishonchingiz komilmi?'),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: ' mahsuloti uchirilmoqda!',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('BEKOR QILISH'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .deleteProduct(productId);
                Navigator.of(ctx).pop();
              },
              child: const Text('O\'CHIRISH'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _products = Provider.of<Products>(context).list;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mahsulotlar',
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          IconButton(
            onPressed: () => _gotoAddProductScreen(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: _products.isNotEmpty
          ? ListView.builder(
              itemCount: _products.length,
              itemBuilder: (_, i) {
                var product = _products[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: product.images[0].startsWith('http')
                        ? NetworkImage(product.images[0])
                        : AssetImage(product.images[0]) as ImageProvider,
                  ),
                  title: Text(product.title),
                  subtitle: Text('\$ ${product.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _gotoAddProductScreen(
                          context,
                          productId: product.id,
                        ),
                        icon: const Icon(
                          Icons.edit,
                          size: 22,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _notifyUserAboutDelete(
                          context,
                          product.title,
                          product.id,
                        ),
                        icon: const Icon(
                          Icons.delete,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text('Mahsulotlar mavjud emas!'),
            ),
    );
  }
}
