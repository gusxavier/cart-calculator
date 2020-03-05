import 'package:cart_calc/entities/cart_item.dart';
import 'package:cart_calc/formatters/currency.dart';
import 'package:cart_calc/formatters/money_input.dart';
import 'package:cart_calc/models/cart.dart';
import 'package:cart_calc/ui/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ItemFormView extends StatefulWidget {
  static final String route = 'ItemForm-View';

  @override
  _ItemFormViewState createState() => _ItemFormViewState();
}

class _ItemFormViewState extends State<ItemFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _priceFieldController = TextEditingController();
  final _quantityFieldController = TextEditingController();

  @override
  void dispose() {
    _nameFieldController.dispose();
    _priceFieldController.dispose();
    _quantityFieldController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      final itemName = _nameFieldController.text;
      final itemPrice = currencyFormatter.parse(_priceFieldController.text);
      final itemQuantity = int.parse(_quantityFieldController.text);

      final newCartItem = CartItem(itemName, itemPrice, itemQuantity);
      final CartModel model = Provider.of<CartModel>(context, listen: false);
      model.addItem(newCartItem);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => CartView()),
          (route) => route.runtimeType == CartView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Adicionar item')),
        body: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Nome',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor, digite o nome do item';
                      }
                      return null;
                    },
                    controller: _nameFieldController,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Preço',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, digite o preço do item';
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          WhitelistingTextInputFormatter.digitsOnly,
                          BlacklistingTextInputFormatter.singleLineFormatter,
                          MoneyInputFormatter.currencyFormatter(
                              currencyFormatter),
                        ],
                        keyboardType: TextInputType.number,
                        controller: _priceFieldController,
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Quantidade',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, digite a quantidade do item';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: _quantityFieldController,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                      onPressed: () => _submitForm(context),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
