import 'package:pollux_test/core/data/adapters/model_adapter.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';

class ExpenseCategoryMock implements ModelAdapter<ExpenseCategory> {
  @override
  Future<int?> count({String where = "", List<Object?>? whereArgs}) {
    return Future.value(10);
  }

  @override
  Future create(ModelAdapter data) {
    return Future.value(data);
  }

  @override
  deleteOne(int id) {
    return "deleted";
  }

  @override
  deleteWhere(String where, List whereArgs) {
    return "deleted";
  }

  @override
  Future<List<ExpenseCategory>> findAll() {
    return Future.value([]);
  }

  @override
  Future<List<ExpenseCategory>> findAndGroupBy(String field) {
    return Future.value([]);
  }

  @override
  Future<ExpenseCategory?> findById(int id) {
    return Future.value(ExpenseCategory(color: 1, id: 1, name: ""));
  }

  @override
  ExpenseCategory fromMap(Map<String, dynamic> data) {
    return ExpenseCategory(
        color: data["color"], id: data["id"], name: data["name"]);
  }

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  updateOne(int id, Map<String, dynamic> newData) {
    return "success";
  }
}
