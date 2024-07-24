import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controls/statemanagement/cart_provider.dart';
import 'package:shop_app/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:  (context)=> CartProvider(),
      child: MaterialApp(
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
            fontFamily: 'lato',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 244, 199, 1),
              primary: const Color.fromARGB(255, 244, 199, 1),
            ),
            inputDecorationTheme: const InputDecorationTheme(
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(83, 0, 0, 0),
                ),
                prefixIconColor: Color.fromRGBO(119, 119, 119, 1)),
            textTheme: const TextTheme(
                titleMedium:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                     titleSmall:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  bodySmall: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.bold, 
                  ),
                  titleLarge: TextStyle(
                        fontSize: 33,
                      ),
                    ),
                    useMaterial3: true,
                    ),
        title: 'CustomFit',
        debugShowCheckedModeBanner: false,
        // home: ProductsDetailsPage(product: products[0],),
        home: const HomePage(),
      ),
    );
  }
}
