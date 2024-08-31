import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/common/custom_list.dart';
import 'package:shop_app/core/statemanagement/cart_provider.dart';
import 'package:shop_app/core/statemanagement/saved_provider.dart';
import 'package:shop_app/features/products_feed/productcard.dart';
import 'package:shop_app/features/service_screens/products_details_page.dart';
import 'package:shop_app/models/globalvariable.dart';

// ignore: must_be_immutable
class WishListProducts extends StatelessWidget {
  const WishListProducts({super.key});

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
      body: ListView.builder(
          itemCount: savedProvider.saved.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final wishItems = savedProvider.saved;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ProductsDetailsPage(product: product)));
                },
                child: CustomList(
                  product: wishItems,
                  id: wishItems[index].id,
                  title: wishItems[index].title,
                  image: wishItems[index].imageUrl,
                  price: wishItems[index].price,
                  backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
                  company: wishItems[index].company,
                  onPressed: () {
                    context
                        .read<SavedProvider>()
                        .removeSaved(wishItems[index].id);
                  },
                ),
              ),
            );
          }),
    );
  }
}
