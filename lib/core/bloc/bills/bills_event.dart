part of 'bills_bloc.dart';

sealed class BillsEvent {}

class ReadBillsRequested extends BillsEvent {
  ReadBillsRequested();
}

class CreateExpenseRequested extends BillsEvent {
  final Map<String, dynamic> values;
  final bool recreate;
  CreateExpenseRequested(this.values, {this.recreate = false});
}

class RestoreExpenseRequested extends BillsEvent {
  final Expense expense;
  RestoreExpenseRequested(this.expense);
}

class DeleteExpenseRequested extends BillsEvent {
  final ExpenseResponse expense;
  DeleteExpenseRequested(this.expense);
}
class DeleteBillsByCategoryRequested extends BillsEvent {
  final ExpenseCategory category;
  DeleteBillsByCategoryRequested(this.category);
}

class EditExpenseRequested extends BillsEvent {
  final int expenseId;
  final Map<String, dynamic> values;
  final ExpenseResponse oldExpenseData;

  EditExpenseRequested(this.expenseId, this.values, this.oldExpenseData);
}
