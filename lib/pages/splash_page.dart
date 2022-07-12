import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jajanan_boeng/pages/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/providers/product_provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:jajanan_boeng/theme.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();

    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: backgroundColor0,
      splash: Image.asset(
        'assets/new_icon/logo-boeng.png',
      ),
      splashIconSize: 200.0,
      nextScreen: SignInPage(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 1500,
    );
  }
}
