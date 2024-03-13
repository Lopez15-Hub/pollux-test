import 'package:pollux_test/core/data/adapters/model_adapter.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/core/data/repositories/category_repository.dart';

import '../models/expense_category_model_mock_test.dart';

class CategoryRepositoryMock implements CategoryRepository {
  @override
  ModelAdapter<ExpenseCategory> get model => ExpenseCategoryMock();
}
