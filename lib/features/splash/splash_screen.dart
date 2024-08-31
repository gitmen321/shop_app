import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/features/auth/screens/login_screen.dart';
import 'package:shop_app/features/home/screens/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }

  void checkLogin() async {
    final spf = await SharedPreferences.getInstance();
    final isLoggedIn = spf.getBool('loggedIn');
    spf.setBool('loggedIn', false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (
        context,
      ) {
        if (isLoggedIn != null && isLoggedIn) {
          return const HomePage();
        } else {
          return const LoginScreen();
        }
      }),
    );
  }
}
