import 'package:pollux_test/core/data/adapters/repository_adapter.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';

class CategoryRepository extends RepositoryAdapter<ExpenseCategory> {
  CategoryRepository() : super(model: ExpenseCategory());
}
