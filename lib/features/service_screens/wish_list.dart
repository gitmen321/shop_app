import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/statemanagement/cart_provider.dart';
import 'package:shop_app/core/statemanagement/saved_provider.dart';
import 'package:shop_app/features/products_feed/productcard.dart';
import 'package:shop_app/models/globalvariable.dart';

// ignore: must_be_immutable
class WishListProducts extends StatelessWidget {
  WishListProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final savedProvider = Provider.of<SavedProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My wishlist',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GridView.builder(
          itemCount: savedProvider.saved.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.75,
          ),
          itemBuilder: (context, index) {
            final wishItems = products[index];

            return ProductCard(
              
                product: wishItems,
                id: wishItems['id'] as String,
                title: wishItems['title'] as String,
                image: wishItems['imageUrl'] as String,
                price: wishItems['price'] as double,
                backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
                company: wishItems['company'] as String);
          }),
    );
  }
}
