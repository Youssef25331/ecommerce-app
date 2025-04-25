import 'package:college_ecommerce_app/pages/bots.dart';
import 'package:college_ecommerce_app/pages/details.dart';
import 'package:college_ecommerce_app/pages/login.dart';
import 'package:college_ecommerce_app/pages/register.dart';
import 'package:college_ecommerce_app/pages/home.dart';
import 'package:college_ecommerce_app/pages/search.dart';
import 'package:college_ecommerce_app/pages/sell.dart';
import 'package:college_ecommerce_app/pages/wishlist.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'averta'),
      title: 'Ecommerce App',
      initialRoute: '/register',
      routes: {
        '/login': (context) => const loginPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const registerPage(),
        '/search': (context) => const searchPage(),
        '/wishlist': (context) => const wishlistPage(),
        '/details': (context) => const detailsPage(),
        '/bots': (context) => const botsPage(),
        '/sell': (context) => const sellPage(),
      },
    );
  }
}
