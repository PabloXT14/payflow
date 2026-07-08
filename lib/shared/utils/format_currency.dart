import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

String formatCurrency({double value = 0, symbol = ""}) {
  return CurrencyTextInputFormatter.currency(
    locale: "pt_BR",
    symbol: symbol,
    decimalDigits: 2,
  ).formatDouble(value);
}
