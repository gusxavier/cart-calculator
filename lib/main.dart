import 'package:cart_calc/models/cart.dart';
import 'package:cart_calc/ui/cart_view.dart';
import 'package:cart_calc/ui/item_form_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => CartModel(), child: CartCalculatorApp()));

class CartCalculatorApp extends StatelessWidget {
  final routes = {
    CartView.route: (BuildContext context) => CartView(),
    ItemFormView.route: (BuildContext context) => ItemFormView(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        buttonColor: Colors.deepPurple,
      ),
      home: CartView(),
      routes: routes,
    );
  }
}
