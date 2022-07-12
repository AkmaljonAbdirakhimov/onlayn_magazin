import 'package:flutter/material.dart';

import '../screens/manage_products_screen.dart';
import '../screens/products_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Widget _buildMenuItem(String title, IconData icon, Function() handler) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Menu'),
        ),
        body: Column(
          children: [
            _buildMenuItem(
              'Bosh Sahifa',
              Icons.home,
              () => Navigator.of(context).pushReplacementNamed(
                ProductsScreen.routeName,
              ),
            ),
            const Divider(),
            _buildMenuItem(
              'Mahsulotlarni boshqarish',
              Icons.category,
              () => Navigator.of(context).pushReplacementNamed(
                ManageProductsScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
