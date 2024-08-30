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
            final wishItems = products[index];

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
                    id: wishItems['id'] as String,
                    title: wishItems['title'] as String,
                    image: wishItems['imageUrl'] as String,
                    price: wishItems['price'] as double,
                    backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
                    company: wishItems['company'] as String, onPressed: (){
                      context.read<SavedProvider>().removeSaved(wishItems);

                      
                    },),
              ),
            );
          }),
    );
  }
}
