
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_app/features/home/screens/home_page.dart';
import 'package:shop_app/features/auth/screens/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
       ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomePage(),),),
       );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color:const Color.fromRGBO(245, 247, 249, 1),
      child: Center(

        child: Text(
                  '\tFoot\nFitCollection',
                  style: Theme.of(context).textTheme.titleLarge,

                ),
      ),

    );
  }
}