import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_tile.dart';
import '../screens/edit_product_screen.dart';

Future<void> _refreshProducts(BuildContext context) async {
  await Provider.of<ProductsProvider>(context, listen: false)
      .fetchAndSyncProducts();
}

class ManageOrdersScreen extends StatelessWidget {
  static const routeName = '/managescreen';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
        },
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductTile(
                products.items[i].id,
                products.items[i].imageUrl,
                products.items[i].title,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
