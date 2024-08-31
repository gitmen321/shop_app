// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shop_app/features/home/screens/home_page.dart';
// import 'package:shop_app/features/auth/screens/login_screen.dart';

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   @override
//   void initState() {
//     checkLogin();
//     super.initState();
//   }

//   void checkLogin() async {
//     final spf = await SharedPreferences.getInstance();
//     final isLoggedIn = spf.getBool('loggedIn');
//     spf.setBool('loggedIn', false);
//     Timer(
//       const Duration(seconds: 3),
//       () => Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (
//           context,
//         ) {
//           if (isLoggedIn != null && isLoggedIn) {
//             return const HomePage();
//           } else {
//             return const LoginScreen();
//           }
//         }),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color.fromRGBO(245, 247, 249, 1),
//       child: Center(
//         child: Text(
//           '\tFoot\nFitCollection',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//     );
//   }
// }

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
