import 'package:pollux_test/core/data/adapters/model_adapter.dart';

class Expense extends ModelAdapter<Expense> {
  final int id;
  final String description;
  final String category;
  final num amount;
  Expense(
      {this.description = "", this.category = "", this.amount = 0, this.id = 0})
      : super('Bills');
  @override
  Expense fromMap(Map<String, dynamic> data) {
    return Expense(
        id: data["id"],
        description: data["description"],
        category: data["category"],
        amount: data["amount"]);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "category": category,
      "amount": amount.toString()
    };
  }
}
