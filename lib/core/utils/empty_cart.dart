import 'package:flutter/material.dart';
import 'package:shop_app/features/home/screens/home_page.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(203, 205, 207, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oops!',
                    style: TextStyle(
                      fontSize: 36,
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'rajdhani',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'It looks like your cart is empty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          fixedSize: const Size(150, 30)),
                          
                      child: const Text(
                        'Shop Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'lato'),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 200,
      ),
    );
  }
}
