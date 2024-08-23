import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/statemanagement/cart_provider.dart';
import 'package:shop_app/core/utils/empty_cart.dart';
import 'package:shop_app/features/checkout_transaction/screens/checkout_page.dart';

class AddCartPage extends StatefulWidget {
  const AddCartPage({
    super.key,
  });

  @override
  State<AddCartPage> createState() => _AddCartPageState();
}
class _AddCartPageState extends State<AddCartPage> {
  double cartTotal = 0;
  double discount = 0;
  double totalAmount = 0;

  CartProvider? cartProvider;

  @override
  void didChangeDependencies() {
    cartProvider = Provider.of<CartProvider>(context);
    _calculateTotal();
    super.didChangeDependencies();
  }

  void _calculateTotal() {
    cartTotal = 0;
    if (cartProvider != null) {
      for (var item in cartProvider!.items) {
        cartTotal += item.price;
      }
    }
    totalAmount = cartTotal - discount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      // body: 
      
      // :
      body: cartProvider!.items.isEmpty ?
      const EmptyCart():
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(
          itemCount: cartProvider?.items.length,
          itemBuilder: (context, index) {
            final cartItem = cartProvider?.items[index];

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(cartItem!.imageUrl),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.title.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Size : ${cartItem.size}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              'Price : ₹${cartItem.price}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
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
                                  'Do you want to remove the product from the cart?'),
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
                                        .removeItem(cartItem.id,cartItem.price as int);
                                    _calculateTotal();
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
                  ],
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar:
      ///////////////////////////////////// 
      
       Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          height: 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price Details',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Total MRP',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Text(
                    '₹${cartTotal.toString()}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text('₹${discount.toString()}')
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '₹${totalAmount.toString()}',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (cartProvider!.items.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                    cartItems: cartProvider!.items,
                                    discount: discount,
                                    cartTotal: cartTotal,
                                  )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Cart is empty"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    fixedSize: const Size(350, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  label: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


