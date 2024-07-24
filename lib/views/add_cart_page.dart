import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controls/statemanagement/cart_provider.dart';

class AddCartPage extends StatelessWidget {
  const AddCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final cartItem = cart[index];

              return ListTile(
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'ARE YOU SURE?',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          content: const Text(
                              'Do you want to remove the product from cart?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "NO",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<CartProvider>()
                                    .removeProduct(cartItem);

                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "YES",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                  radius: 40,
                ),
                title: Text(
                  cartItem['title'].toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  'Size : ${cartItem['size']}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }));
  }
}
