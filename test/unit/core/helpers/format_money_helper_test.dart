import 'package:flutter_test/flutter_test.dart';
import 'package:pollux_test/core/helpers/format_money_helper.dart';

void main() {
  group("0000_tests_function_formatMoney", () {
    const input = 1500;
    const expectedInput = "\$ 1.500,00";
    test("Pass a number a return a formatted string with the currency in ARS",
        () => expect(formatMoney(input), expectedInput));
  });
  group("0001_tests_function_formatMoney", () {
    const input = 1500.50;
    const expectedInput = "\$ 1.500,50";
    test("Pass a number with decimals a return a formatted string with the currency in ARS",
        () => expect(formatMoney(input), expectedInput));
  });
}
