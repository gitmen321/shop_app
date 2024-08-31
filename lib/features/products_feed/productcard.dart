import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/statemanagement/cart_provider.dart';
import 'package:shop_app/core/statemanagement/saved_provider.dart';

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;

  final String id;
  final String title;
  final String image;
  final double price;
  final String company;
  final Color backgroundColor;
  const ProductCard(
      {super.key,
      required this.id,
      required this.product,
      required this.title,
      required this.image,
      required this.price,
      required this.backgroundColor,
      required this.company});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int? exists;

  void onPressed() {
    print(widget.product['id']);
    exists = context.read<SavedProvider>().addSaved(
          widget.product['id'] as String,
          widget.product['title'] as String,
          widget.product['company'] as String,
          widget.product['price'] as double,
          widget.product['imageUrl'] as String,
        );
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Product saved"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('exists');
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: onPressed,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    exists == -1 ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.company,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '\₹${widget.price}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Image.asset(
            widget.image,
            height: 170,
          )),
        ],
      ),
    );
  }
}
