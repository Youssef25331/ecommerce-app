import 'package:college_ecommerce_app/views/bots_page.dart';
import 'package:college_ecommerce_app/views/details_page.dart';
import 'package:college_ecommerce_app/views/login_page.dart';
import 'package:college_ecommerce_app/views/register_page.dart';
import 'package:college_ecommerce_app/views/home_page.dart';
import 'package:college_ecommerce_app/views/search_page.dart';
import 'package:college_ecommerce_app/views/sell_page.dart';
import 'package:college_ecommerce_app/views/wishlist_page.dart';
import 'package:college_ecommerce_app/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'averta'),
        title: 'Ecommerce App',
        initialRoute: '/register',
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/register': (context) => const RegisterPage(),
          '/search': (context) => const SearchPage(),
          '/wishlist': (context) => const WishlistPage(),
          '/details': (context) => const DetailsPage(),
          '/bots': (context) => const BotsPage(),
          '/sell': (context) => const SellPage(),
        },
      ),
    );
  }
}
