part of 'category_bloc.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryUpdated extends CategoryState {}

final class CategoriesEmpty extends CategoryState {}

final class CategoriesRetrieved extends CategoryState {
  final List<ExpenseCategory> categories;
  CategoriesRetrieved(this.categories);
}

final class CategoryCreated extends CategoryState {
  final bool recreated;
  CategoryCreated({this.recreated = false});
}

final class CategoryDeleted extends CategoryState {
  final ExpenseCategory deleteCategoryData;
  CategoryDeleted(this.deleteCategoryData);
}

final class CategoryError extends CategoryState {
  final String reason;
  CategoryError(this.reason);
}
