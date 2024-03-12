import 'package:flutter/material.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import 'expense_item_widget.dart';

class BillList extends StatelessWidget {
  const BillList({super.key, required this.expense});
  final List<ExpenseResponse> expense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expense.length,
      itemBuilder: (context, index) => ExpenseItem(expense: expense[index]),
    );
  }
}
