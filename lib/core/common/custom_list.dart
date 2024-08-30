import 'package:flutter/material.dart';

class CustomList extends StatefulWidget {
  final Map<String, Object> product;
  final String id;
  final String title;
  final String image;
  final double price;
  final String company;
  final Color backgroundColor;
  final Function onPressed;

  const CustomList({
    super.key,
    required this.id,
    required this.product,
    required this.title,
    required this.image,
    required this.price,
    required this.backgroundColor,
    required this.company,
    required this.onPressed
  });

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: widget.backgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Image.asset(
          widget.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Row(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.company,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  '₹${widget.price}',
                  style: Theme.of(context).textTheme.bodySmall,
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
                                  onPressed:(){
                                    widget.onPressed();
                                     Navigator.of(context).pop();
                                  } ,
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
          ],
        ),
        
      ),
    );
  }
}
