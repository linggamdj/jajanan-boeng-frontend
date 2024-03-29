import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jajanan_boeng/pages/app_info_page.dart';
import 'package:jajanan_boeng/pages/procedure_page.dart';
import 'package:jajanan_boeng/pages/transaction_page.dart';
import 'package:jajanan_boeng/providers/logout_provider.dart';
import 'package:jajanan_boeng/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/pages/cart_page.dart';
import 'package:jajanan_boeng/pages/checkout_page.dart';
import 'package:jajanan_boeng/pages/checkout_success_page.dart';
import 'package:jajanan_boeng/pages/edit_profile_page.dart';
import 'package:jajanan_boeng/pages/change_password_page.dart';
import 'package:jajanan_boeng/pages/home/main_page.dart';
import 'package:jajanan_boeng/pages/sign_in_page.dart';
import 'package:jajanan_boeng/pages/sign_up_page.dart';
import 'package:jajanan_boeng/pages/splash_page.dart';
import 'package:jajanan_boeng/providers/auth_provider.dart';
import 'package:jajanan_boeng/providers/cart_provider.dart';
import 'package:jajanan_boeng/providers/page_provider.dart';
import 'package:jajanan_boeng/providers/product_provider.dart';
import 'package:jajanan_boeng/providers/checkout_provider.dart';
import 'package:jajanan_boeng/providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/about': (context) => AppInfoPage(),
          '/procedure': (context) => ProcedurePage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/change-password': (context) => ChangePasswordPage(),
          '/cart': (context) => CartPage(),
          '/transactions': (context) => TransactionPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
        },
      ),
    );
  }
}
