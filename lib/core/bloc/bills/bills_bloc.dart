import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/core/data/models/expense_model.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import 'package:pollux_test/core/data/repositories/category_repository.dart';
import 'package:pollux_test/core/data/repositories/expense_repository.dart';
import 'package:pollux_test/core/helpers/format_amount_helper.dart';

part 'bills_event.dart';
part 'bills_state.dart';

class BillsBloc extends Bloc<BillsEvent, BillsState> {
  final ExpenseRepository repository;
  final CategoryRepository categoryRepository;
  BillsBloc(this.repository, this.categoryRepository) : super(BillsInitial()) {
    on<ReadBillsRequested>((event, emit) async {
      try {
        final List<Expense> bills = await repository.model.findAll();
        if (bills.isEmpty) {
          emit(BillsEmpty());
        } else {
          final billFutures = bills.map((expense) async {
            ExpenseCategory? category;
            if (expense.category != "null") {
              category = await categoryRepository.model
                  .findById(int.parse(expense.category));
            }

            return ExpenseResponse(
                id: expense.id,
                amount: expense.amount,
                category: category ??
                    ExpenseCategory(
                      id: -5,
                      name: "Sin categoría",
                    ),
                description: expense.description);
          });
          final mappedBills = await Future.wait(billFutures);
          emit(BillsRetrieved(mappedBills));
        }
      } catch (error) {
        debugPrint(error.toString());
        emit(BillsError(
            "Ha ocurrido un error obteniendo tus gastos. Intenta de nuevo más tarde."));
      }
    });
    on<RestoreExpenseRequested>((event, emit) async {
      add(CreateExpenseRequested({...event.expense.toMap()}, recreate: true));
    });
    on<CreateExpenseRequested>((event, emit) async {
      try {
        final newExpense = Expense(
          description: event.values["description"],
          category: event.values["category"].toString(),
          amount: formatAmount(event.values["amount"].toString()),
        );
        await repository.model.create(newExpense);
        emit(ExpenseCreated(recreated: event.recreate));

        add(ReadBillsRequested());
      } catch (error) {
        const message =
            "Ha ocurrido un error creando el gasto. Intenta de nuevo más tarde.";
        debugPrint("$message $error");
        emit(BillsError(message));
      }
    });
    on<DeleteExpenseRequested>((event, emit) async {
      try {
        await repository.model.deleteOne(event.expense.id);
        emit(ExpenseDeleted(Expense(
            description: event.expense.description,
            amount: event.expense.amount,
            category: event.expense.category.id.toString(),
            id: event.expense.id)));
        add(ReadBillsRequested());
      } catch (error) {
        emit(BillsError(
            "Ha ocurrido un error eliminando el gasto. Intenta de nuevo más tarde."));
      }
    });
    on<DeleteBillsByCategoryRequested>((event, emit) async {
      try {
        await repository.removeByCategory(event.category.id);
        emit(BillsRemoved(event.category));
        add(ReadBillsRequested());
      } catch (error) {
        emit(BillsError(
            "Ha ocurrido un error eliminando los gastos. Intenta de nuevo más tarde."));
      }
    });
    on<EditExpenseRequested>((event, emit) async {
      try {
        final newExpense = Expense(
          description:
              event.values["description"] ?? event.oldExpenseData.description,
          category: event.values["category"] ?? event.oldExpenseData.category,
          amount: formatAmount(
              event.values["amount"] ?? event.oldExpenseData.amount.toString()),
        );
        await repository.model.updateOne(event.expenseId, newExpense.toMap());
        emit(ExpenseUpdated());
        add(ReadBillsRequested());
      } catch (error) {
        const message =
            "Ha ocurrido un error creando el gasto. Intenta de nuevo más tarde.";
        debugPrint("$message $error");
        emit(BillsError(message));
      }
    });
  }
}
