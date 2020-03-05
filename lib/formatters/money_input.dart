import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MoneyInputFormatter extends TextInputFormatter {
  NumberFormat _currencyFormatter;

  MoneyInputFormatter({@required String localeTag, String symbol = ''}) {
    _currencyFormatter =
        new NumberFormat.currency(locale: localeTag, symbol: symbol);
  }

  MoneyInputFormatter.currencyFormatter(NumberFormat currencyFormatter) {
    _currencyFormatter = currencyFormatter;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueAsDouble = _textToDouble(newValue.text) / 100;

    if (newValueAsDouble == 0.0) {
      return _buildTextEditingValue('');
    }

    final String formattedMoney = _currencyFormatter.format(newValueAsDouble);
    return _buildTextEditingValue(formattedMoney);
  }

  double _textToDouble(String text) {
    return double.parse(_replaceTextForDoubleParsing(text));
  }

  String _replaceTextForDoubleParsing(String text) {
    return text.replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(',', '.');
  }

  TextEditingValue _buildTextEditingValue(String textValue) {
    return TextEditingValue(
        text: textValue,
        selection: TextSelection.collapsed(offset: textValue.length));
  }
}
