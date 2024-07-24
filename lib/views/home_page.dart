import 'package:flutter/material.dart';
import 'package:shop_app/controls/products_list.dart';
import 'package:shop_app/views/add_cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  int currentPage = 0;
  List<Widget> pages = const [ProductsList(),AddCartPage()];

  @override
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,

      body:IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 35,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,

        items:const[
          BottomNavigationBarItem(icon: Icon(Icons.home,),
          label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
          label: '')
        ] ),
    );
  }
}
