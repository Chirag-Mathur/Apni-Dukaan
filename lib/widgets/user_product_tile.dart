import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/edit_product_screen.dart';
import '../provider/products_provider.dart';

class UserProductTile extends StatelessWidget {
  final String id;
  final String imageurl;
  final String title;
  UserProductTile(this.id, this.imageurl, this.title);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .removeProduct(id);
                } catch (_) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text('Deletion Failed'),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
