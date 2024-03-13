import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/presentation/views/expense_form/expense_form_view.dart';
import 'package:pollux_test/presentation/widgets/bills/bill_list_widget.dart';
import 'package:pollux_test/presentation/widgets/app/no_data_widget.dart';
import 'package:pollux_test/presentation/widgets/home/pie_chart_widget.dart';

class Bills extends StatelessWidget {
  const Bills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final billsBloc = BlocProvider.of<BillsBloc>(context);
    final navigatorCubit = BlocProvider.of<NavigatorCubit>(context);

    billsBloc.add(ReadBillsRequested());
    return BlocBuilder<BillsBloc, BillsState>(
      builder: (context, state) {
        if (state is BillsEmpty) {
          return NoData(
            message: "No tenés gastos",
            action: () =>
                navigatorCubit.pushWidget(context, const ExpenseForm()),
          );
        }
        if (state is BillsError) {
          return Center(
            child: Text(
              state.reason,
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state is BillsRetrieved) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                BillsPieChart(bills: state.bills),
                const Divider(),
                BillList(expense: state.bills),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
