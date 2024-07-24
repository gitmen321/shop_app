import 'package:flutter/material.dart';

class Productcard extends StatelessWidget {
  final String title;
  final String image;
  final double price;
  final String company;
  final Color backgroundColor;
  const Productcard(
      {super.key,
      required this.title,
      required this.image,
      required this.price,
      required this.backgroundColor,
      required this.company});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              company,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$$price',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Image.asset(
              image,
              height: 170,
            )),
          ],
        ),
      
    );
  }
}
