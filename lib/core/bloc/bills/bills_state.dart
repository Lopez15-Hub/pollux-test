part of 'bills_bloc.dart';

sealed class BillsState {}

final class BillsInitial extends BillsState {}

final class BillsEmpty extends BillsState {}

final class BillsRemoved extends BillsState {
  final ExpenseCategory category;
  BillsRemoved(this.category);
}

final class ExpenseCreated extends BillsState {
  final bool recreated;
  ExpenseCreated({this.recreated = false});
}

final class ExpenseDeleted extends BillsState {
  Expense deletedExpenseData;
  ExpenseDeleted(this.deletedExpenseData);
}

final class BillsRetrieved extends BillsState {
  List<ExpenseResponse> bills;
  BillsRetrieved(this.bills);
}

final class BillsError extends BillsState {
  final String reason;
  BillsError(this.reason);
}

final class ExpenseUpdated extends BillsState {}
