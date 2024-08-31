import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/common/search_field.dart';
import 'package:shop_app/features/scratchcard/scratch_card.dart';
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
    "All",
    "Adidas",
    "Nike",
    "Bata",
    "Puma",
    "Reebok",
    "New balance",
    "Skechers",
    "Woodland",
    "Vans"
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
  bool isNewUser = false;

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
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _showScratchCardDialog());
    }
  }

  void _showScratchCardDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 200,
                maxHeight: 200,
              ),
              child: GestureDetector(
                onTapCancel: _applyScratchCardReward,
                onTap: _applyScratchCardReward,
                child: ScratchCard(
                  overlayColor: Colors.grey,
                  strokeWidth: 20.0,
                  hiddenChild: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                    ),
                    constraints:
                        const BoxConstraints(maxHeight: 300, maxWidth: 300),
                    alignment: Alignment.center,
                    child: const Text(
                      'You Won!',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }

  void _applyScratchCardReward() {
    setState(() {
      final randomIndex = Random().nextInt(products.length);
      products[randomIndex]['price'] = 0.0;
    });

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Congratulations! You got a product for free!'),
      ),
    );
  }

  String searchKeyWord = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((product) => selectedFilter == 'All'
            ? product['company']
                    .toLowerCase()
                    .contains(searchKeyWord.toLowerCase()) ||
                product['title']
                    .toLowerCase()
                    .contains(searchKeyWord.toLowerCase())
            : product['company'] == selectedFilter &&
                product['title']
                    .toLowerCase()
                    .contains(searchKeyWord.toLowerCase()))
        .toList();

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: Text(
              //     'Foot\nFitCollection',
              //     style: Theme.of(context).textTheme.titleLarge,
              //   ),
              // ),
              const Padding(
                  padding: EdgeInsets.all(20),
                  child: Image(
                    image: AssetImage('assets/images/app_img_logo_white.png'),
                    color: Colors.black,
                    width: 70,
                    height: 70,
                  )),
              Expanded(
                child: SearchField(
                  onChanged: (value) {
                    setState(() {
                      searchKeyWord = value;
                    });
                  },
                ),
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
                            color: selectedFilter == filter
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(filter),
                        ],
                      ),
                      labelStyle: selectedFilter == filter
                          ? const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          : const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductsDetailsPage(product: product)));
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
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductsDetailsPage(product: product)));
                        },
                        child: ProductCard(
                          id: product['id'] as String,
                          title: product['title'] as String,
                          image: product['imageUrl'] as String,
                          price: product['price'] as double,
                          company: product['company'] as String,
                          backgroundColor:
                              const Color.fromRGBO(245, 247, 249, 1),
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
