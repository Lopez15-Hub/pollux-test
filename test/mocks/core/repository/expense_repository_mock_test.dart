import 'package:pollux_test/core/data/adapters/model_adapter.dart';
import 'package:pollux_test/core/data/models/expense_model.dart';
import 'package:pollux_test/core/data/repositories/expense_repository.dart';

import '../models/expense_model_mock_test.dart';

class ExpenseRepositoryMock implements ExpenseRepository {
  @override
  ModelAdapter<Expense> get model => ExpenseMock();

  @override
  Future<void> removeByCategory(int categoryId) {
    return Future(() => null);
  }
}
