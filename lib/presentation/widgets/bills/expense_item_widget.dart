import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import 'package:pollux_test/core/helpers/format_amount_helper.dart';
import 'package:pollux_test/core/helpers/format_money_helper.dart';
import 'package:pollux_test/presentation/views/expense_form/expense_form_view.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final ExpenseResponse expense;

  @override
  Widget build(BuildContext context) {
    final billsBloc = BlocProvider.of<BillsBloc>(context);
    final navigatorCubit = BlocProvider.of<NavigatorCubit>(context);
    final textWithColor = TextStyle(
        color: expense.category.id != null
            ? Color(expense.category.color)
            : Colors.white);
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      key: Key(expense.id.toString()),
      onDismissed: (direction) {
        billsBloc.add(DeleteExpenseRequested(expense));
      },
      child: ListTile(
        onTap: () => navigatorCubit.pushWidget(
            context,
            ExpenseForm(
              expenseData: expense,
            )),
        leading: Icon(
          Icons.monetization_on,
          color: expense.category.id != null
              ? Color(expense.category.color)
              : Colors.white,
        ),
        title: Text(
          expense.description,
          style: textWithColor,
        ),
        subtitle: Text(
          expense.category.name,
          style: textWithColor,
        ),
        trailing: Text(
          formatMoney(expense.amount),
          style: TextStyle(
            fontSize: 18,
            color: expense.category.id != null
                ? Color(expense.category.color)
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
