import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import './styles/onlayn_magazin_styles.dart';
import './screens/products_screen.dart';
import './screens/manage_products_screen.dart';
import './screens/add_edit_product_screen.dart';
import './screens/cart_screen.dart';
import './models/product.dart';
import './models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = OnlaynMagazinStyles.theme();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (_) => Products()),
        ChangeNotifierProvider<CartItems>(create: (_) => CartItems()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Onlayn Magazin',
        theme: theme,
        initialRoute: ProductsScreen.routeName,
        routes: {
          ProductsScreen.routeName: (_) => const ProductsScreen(),
          ManageProductsScreen.routeName: (_) => const ManageProductsScreen(),
          AddEditScreen.routeName: (_) => const AddEditScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
        },
      ),
    );
  }
}
