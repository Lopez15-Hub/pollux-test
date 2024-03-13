import 'package:flutter_test/flutter_test.dart';
import 'package:pollux_test/core/helpers/format_amount_helper.dart';

void main() {
  group("0000_tests_function_formatAmount", () {
    const input = "1500";
    const expectedInput = 1500;
    test("Pass a single String number, parse and return a num",
        () => expect(formatAmount(input), expectedInput));
  });
  group("0001_tests_function_formatAmount", () {
    const input = "1500,50";
    const expectedInput = 1500.50;
    test("Pass a String number with comma, parse and return a num with a point",
        () => expect(formatAmount(input), expectedInput));
  });
}
