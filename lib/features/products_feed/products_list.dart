import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/common/search_field.dart';
import 'package:shop_app/features/auth/screens/login_screen.dart';
import 'package:shop_app/models/globalvariable.dart';
import 'package:shop_app/features/products_feed/productcard.dart';
import 'package:shop_app/features/service_screens/products_details_page.dart';
import 'package:simple_icons/simple_icons.dart';
import 'dart:math';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final List<String> filters = const [
    "All", "Addidas", "Nike", "Bata", "Puma", "Reebok", "New balance", "Skechers", "Woodland", "Vans"
  ];

  final List<IconData> filterIcons = [
    Icons.clear_all_sharp,
    SimpleIcons.adidas,
    SimpleIcons.nike,
    SimpleIcons.bata,
    SimpleIcons.puma,
    SimpleIcons.reebok,
    SimpleIcons.newbalance,
     SimpleIcons.puma,
    SimpleIcons.reebok,
    SimpleIcons.newbalance,
  ];

  late String selectedFilter;
  bool isNewUser = false; // You will set this based on Firebase

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    newUser();
  }

  void newUser() async {
    final spf = await SharedPreferences.getInstance();
    final isNewUser = spf.getBool('isNewUser');
    if (isNewUser != null && isNewUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showScratchCardDialog());
    }
  }

  void _showScratchCardDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: _applyScratchCardReward,
                child: Image.asset(
                  'assets/images/pngegg.png', // Replace with your scratch card image path
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _applyScratchCardReward() {
    setState(() {
      final randomIndex = Random().nextInt(products.length);
      products[randomIndex]['price'] = 0.0; // Set the price of the selected product to zero
    });

    Navigator.of(context).pop(); // Close the dialog

    ScaffoldMessenger.of(context).showSnackBar(
     const  SnackBar(
        content: Text('Congratulations! You got a product for free!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final spf = await SharedPreferences.getInstance();
                  spf.setBool('loggedIn', false);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Foot\nFitCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const Expanded(
                child: SearchField(),
              ),
            ],
          ),
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final icon = filterIcons[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1)),
                      label: Row(
                        children: [
                          Icon(
                            icon,
                            color: selectedFilter == filter ? Colors.white : Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(filter),
                        ],
                      ),
                      labelStyle: selectedFilter == filter
                          ? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
                          : const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductsDetailsPage(product: product)));
                        },
                        child: ProductCard(
                          id: product['id'] as String,
                          title: product['title'] as String,
                          image: product['imageUrl'] as String,
                          price: product['price'] as double,
                          company: product['company'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromARGB(255, 183, 187, 189)
                              : const Color.fromRGBO(245, 247, 249, 1),
                          product: product,
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductsDetailsPage(product: product)));
                        },
                        child: ProductCard(
                          id: product['id'] as String,
                          title: product['title'] as String,
                          image: product['imageUrl'] as String,
                          price: product['price'] as double,
                          company: product['company'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromARGB(255, 183, 187, 189)
                              : const Color.fromRGBO(245, 247, 249, 1),
                          product: product,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
