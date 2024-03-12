part of 'category_bloc.dart';

sealed class CategoryEvent {}

class ReadCategoriesRequested extends CategoryEvent {
  ReadCategoriesRequested();
}

class CreateCategoryRequested extends CategoryEvent {
  final Map<String, dynamic> values;
  final bool recreate;
  CreateCategoryRequested(this.values, {this.recreate = false});
}

class RestoreCategoryRequested extends CategoryEvent {
  final ExpenseCategory category;
  RestoreCategoryRequested(this.category);
}

class EditCategoryRequested extends CategoryEvent {
  final int categoryId;
  final Map<String, dynamic> values;
  final ExpenseCategory oldCategoryData;

  EditCategoryRequested(this.categoryId, this.values, this.oldCategoryData);
}

class DeleteCategoryRequested extends CategoryEvent {
  final ExpenseCategory category;
  DeleteCategoryRequested(this.category);
}
