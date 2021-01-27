import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/products_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../provider/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../provider/products_provider.dart';
import 'cart_screens.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isInit = true;
  var _showOnlyFavourite = false;
  var _isLoading = true;

  // @override
  // void initState() {
  //   Provider.of<ProductsProvider>(context, listen: false)
  //       .fetchAndSyncProducts();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      Provider.of<ProductsProvider>(context)
          .fetchAndSyncProducts()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showOnlyFavourite = true;
                } else {
                  _showOnlyFavourite = false;
                }
              });

              print(selectedValue);
              print(_showOnlyFavourite);
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favourites"),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('All Products'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
              //value : 1.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavourite),
    );
    //return scaffold;
  }
}
