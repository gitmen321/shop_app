import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/statemanagement/cart_provider.dart';
import 'package:shop_app/core/statemanagement/saved_provider.dart';
import 'package:shop_app/features/home/screens/home_page.dart';
import 'package:shop_app/features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDb0bzdURbg68cvZHYDrcudgoJOuaDW_aM",
          appId: "1:1001076967261:android:1c2b9d77f4e48d95b68ab4",
          messagingSenderId: "1001076967261",
          projectId: "footcollections-ede08",
          storageBucket: "footcollections-ede08.appspot.com"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SavedProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          fontFamily: 'lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 0, 0),
            primary: const Color.fromARGB(255, 0, 0, 0),
          ),
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(83, 0, 0, 0),
              ),
              prefixIconColor: Color.fromRGBO(119, 119, 119, 1)),
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
            ),
          ),
          useMaterial3: true,
        ),
        title: 'CustomFit',
        debugShowCheckedModeBanner: false,
        home: const Splash(),
      ),
    );
  }
}
