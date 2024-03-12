import 'package:pollux_test/core/data/adapters/repository_adapter.dart';
import 'package:pollux_test/core/data/models/expense_model.dart';

class ExpenseRepository extends RepositoryAdapter<Expense> {
  ExpenseRepository() : super(model: Expense());
  Future<void> removeByCategory(int categoryId) async {
    await model.deleteWhere("category = ?", [categoryId]);
  }
}
