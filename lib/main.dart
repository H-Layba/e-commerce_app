import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'views/home/home_page.dart';
import 'views/cart/cart_page.dart';
import 'views/wishlist/wishlist_page.dart';
import 'views/support/support_page.dart';
import 'views/support/chat_support_page.dart';
import 'views/support/feedback_page.dart';
import 'views/checkout/checkout_page.dart';
import 'views/auth/login_page.dart';
import 'views/auth/signup_page.dart';
import 'views/profile/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/cart': (context) => CartPage(),
          '/wishlist': (context) => WishlistPage(),
          '/support': (context) => SupportPage(),
          '/support/chat': (context) => ChatSupportPage(),
          '/support/feedback': (context) => FeedbackPage(),
          '/checkout': (context) => CheckoutPage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/profile': (context) => ProfilePage(),
        },
      ),
    );
  }
}
