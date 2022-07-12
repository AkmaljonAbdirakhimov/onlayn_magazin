import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../widgets/products_list/shopping_bag.dart';
import '../widgets/products_list/product_list.dart';
import '../widgets/products_list/favorites_list.dart';
import '../widgets/custom_drawer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Rexar Shop',
            style: Theme.of(context).textTheme.headline2,
          ),
          actions: const [
            ShoppingBag(),
          ],
        ),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: NestedScrollView(
            headerSliverBuilder: (ctx, isScrolling) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Sevimli buyumingizni tanlang",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.black)),
                        const Text("Ajoyiblik har bir buyumda mujassam"),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  pinned: true,
                  flexibleSpace: Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TabBar(
                      indicatorColor: Colors.transparent,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 18),
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14),
                      tabs: const [
                        Tab(text: 'Barchasi'),
                        Tab(text: 'Sevimli'),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: const TabBarView(
              children: [
                ProductList(),
                FavoriteList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
