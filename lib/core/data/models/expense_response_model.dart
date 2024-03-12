import 'dart:convert';

import 'package:pollux_test/core/data/models/expense_category_model.dart';

ExpenseResponse expenseResponseFromJson(String str) =>
    ExpenseResponse.fromJson(json.decode(str));

String expenseResponseToJson(ExpenseResponse data) =>
    json.encode(data.toJson());

class ExpenseResponse {
  int id;
  String description;
  num amount;
  ExpenseCategory category;

  ExpenseResponse({
    required this.id,
    required this.description,
    required this.amount,
    required this.category,
  });

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) =>
      ExpenseResponse(
        id: json["id"],
        description: json["description"],
        amount: json["amount"],
        category: ExpenseCategory().fromMap(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "amount": amount,
        "category": category.toMap(),
      };
}
