import 'package:pollux_test/core/data/adapters/model_adapter.dart';
import 'package:pollux_test/core/data/models/expense_model.dart';

class ExpenseMock implements ModelAdapter<Expense> {
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
  Future<List<Expense>> findAll() {
    return Future.value([]);
  }

  @override
  Future<List<Expense>> findAndGroupBy(String field) {
    return Future.value([]);
  }

  @override
  Future<Expense?> findById(int id) {
    return Future.value(
        Expense(amount: 0, category: "", description: "", id: 0));
  }

  @override
  Expense fromMap(Map<String, dynamic> data) {
    return Expense(
        amount: data["amount"],
        category: data["category"],
        description: data["description"],
        id: data["id"]);
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
