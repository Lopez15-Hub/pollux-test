import 'package:intl/intl.dart';

String formatMoney(num amount) {
  final formatter = NumberFormat('\$ #,##0.00', 'es_AR');
  return formatter.format(amount);
}
