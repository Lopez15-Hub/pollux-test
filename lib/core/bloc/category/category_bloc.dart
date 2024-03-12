import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pollux_test/core/data/repositories/category_repository.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<ReadCategoriesRequested>((event, emit) async {
      try {
        final List<ExpenseCategory> categories =
            await repository.model.findAll();
        if (categories.isEmpty) {
          emit(CategoriesEmpty());
        } else {
          emit(CategoriesRetrieved(categories));
        }
      } catch (error) {
        debugPrint(error.toString());
        emit(CategoryError(
            "Ha ocurrido un error obteniendo tus categorias. Intenta de nuevo más tarde."));
      }
    });
    on<RestoreCategoryRequested>((event, emit) async {
      add(CreateCategoryRequested({...event.category.toMap()}, recreate: true));
    });
    on<CreateCategoryRequested>((event, emit) async {
      try {
        final newCategory = ExpenseCategory(
          name: event.values["name"],
          color: event.values["color"],
        );
        await repository.model.create(newCategory);
        emit(CategoryCreated(recreated: event.recreate));

        add(ReadCategoriesRequested());
      } catch (error) {
        debugPrint(error.toString());
        const message =
            "Ha ocurrido un error creando la categoría. Intenta de nuevo más tarde.";
        emit(CategoryError(message));
      }
    });
    on<DeleteCategoryRequested>((event, emit) async {
      try {
        await repository.model.deleteOne(event.category.id);
        emit(CategoryDeleted(event.category));
        add(ReadCategoriesRequested());
      } catch (error) {
        emit(CategoryError(
            "Ha ocurrido un error eliminando la categoría. Intenta de nuevo más tarde."));
      }
    });
    on<EditCategoryRequested>((event, emit) async {
      try {
        final newCategory = ExpenseCategory(
          name: event.values["name"] ?? event.oldCategoryData.name,
          color: event.values["color"] ?? event.oldCategoryData.color,
        );
        await repository.model.updateOne(event.categoryId, newCategory.toMap());
        emit(CategoryUpdated());
        add(ReadCategoriesRequested());
      } catch (error) {
        debugPrint(error.toString());
        const message =
            "Ha ocurrido un error creando la categoría. Intenta de nuevo más tarde.";
        emit(CategoryError(message));
      }
    });
  }
}
