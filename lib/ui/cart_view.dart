import 'package:cart_calc/entities/cart_item.dart';
import 'package:cart_calc/formatters/currency.dart';
import 'package:cart_calc/models/cart.dart';
import 'package:cart_calc/ui/item_form_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  static final String route = 'Cart-View';

  void _goToItemForm(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ItemFormView()));
  }

  Widget _buildItems(context) {
    return Consumer<CartModel>(builder: (context, model, child) {
      return ListView.builder(
          itemCount: model.cartItems.length,
          itemBuilder: (context, index) {
            return _buildItem(model.cartItems[index]);
          });
    });
  }

  Widget _buildItem(CartItem item) {
    return ListTile(
        leading: Column(
            children: <Widget>[Text('${item.quantity}x')],
            mainAxisAlignment: MainAxisAlignment.center),
        title: Text(item.name),
        trailing: Text(
            '${currencyFormatter.format(item.price)} (${currencyFormatter.format(item.totalPrice())})'));
  }

  double cartTotal(List<CartItem> cartItems) {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice());
  }

  String cartTotalFormatted(List<CartItem> cartItems) {
    return currencyFormatter.format(cartTotal(cartItems));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de compras'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: _buildItems(context)),
            Container(
              height: 80.0,
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Consumer<CartModel>(builder: (context, model, child) {
                    return Text(
                      'Total: ${cartTotalFormatted(model.cartItems)}',
                      style: TextStyle(fontSize: 20.0),
                    );
                  }),
                  Ink(
                      decoration: ShapeDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: CircleBorder()),
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _goToItemForm(context),
                          color: Colors.white))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
