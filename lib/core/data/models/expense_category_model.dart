import 'package:pollux_test/core/data/adapters/model_adapter.dart';


class ExpenseCategory extends ModelAdapter<ExpenseCategory> {
  final int? id;
  final String name;
  final int color;
  ExpenseCategory({this.name = "", this.color = 0, this.id = 0})
      : super('Categories');
  @override
  ExpenseCategory fromMap(Map<String, dynamic> data) {
    return ExpenseCategory(
      id: data["id"],
      name: data["name"],
      color: data["color"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "color": color,
    };
  }
}
