import 'package:flutter_test/flutter_test.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import '../../../../mocks/core/repository/category_repository_mock_test.dart';
import '../../../../mocks/core/repository/expense_repository_mock_test.dart';

void main() {
  late BillsBloc billsBloc;
  setUp(() {
    billsBloc = BillsBloc(ExpenseRepositoryMock(), CategoryRepositoryMock());
  });
  group("0000_test_BillsInitial", () {
    test('initial state is BillsInitial()', () {
      expect(billsBloc.state, isA<BillsInitial>());
    });
  });
  group("0001_test_ReadBillsRequested", () {
    blocTest(
      'Read bills and expect empty array',
      build: () => billsBloc,
      act: (bloc) => bloc.add(ReadBillsRequested()),
      expect: () => [isA<BillsEmpty>()],
    );
  });

  group("0002_test_DeleteExpenseRequested", () {
    final expenseMock = ExpenseResponse(
        amount: 0,
        category: ExpenseCategory(color: 0, id: 0, name: ""),
        description: "",
        id: 0);

    blocTest(
      'Delete bill',
      build: () => billsBloc,
      act: (bloc) => bloc.add(DeleteExpenseRequested(expenseMock)),
      expect: () => [isA<ExpenseDeleted>(), isA<BillsEmpty>()],
    );
  });
  group("0003_test_EditExpenseRequested", () {
    final expenseMock = ExpenseResponse(
        amount: 0,
        category: ExpenseCategory(color: 0, id: 0, name: ""),
        description: "",
        id: 0);

    blocTest(
      'Update bill',
      build: () => billsBloc,
      act: (bloc) => bloc.add(EditExpenseRequested(
          0, {"description": "picsum", "category": "asdasd"}, expenseMock)),
      expect: () => [isA<ExpenseUpdated>(), isA<BillsEmpty>()],
    );
  });
  group("0004_test_CreateExpenseRequested", () {
    blocTest(
      'Create Expense',
      build: () => billsBloc,
      act: (bloc) => bloc.add(CreateExpenseRequested(
          {"description": "picsum", "category": 0, "amount": 12500})),
      expect: () => [isA<ExpenseCreated>(), isA<BillsEmpty>()],
    );
  });
}
