import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/page_manager/page_manager_cubit.dart';
import 'package:pollux_test/core/bloc/snackbar/snackbar_cubit.dart';
import 'package:pollux_test/presentation/views/bills/bills_view.dart';
import 'package:pollux_test/presentation/views/categories/categories_view.dart';
import 'package:pollux_test/presentation/widgets/app/custom_appbar_widget.dart';
import 'package:pollux_test/presentation/widgets/app/custom_bottombar_widget.dart';
import 'package:pollux_test/presentation/widgets/app/custom_fab_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final billsBloc = BlocProvider.of<BillsBloc>(context);
    final snackbarCubit = BlocProvider.of<SnackbarCubit>(context);
    return Scaffold(
      floatingActionButton: const CustomFab(),
      appBar: const CustomAppbar(),
      bottomNavigationBar: const CustomBottombar(),
      body: BlocListener<BillsBloc, BillsState>(
        listener: (context, state) {
          if (state is ExpenseDeleted) {
            snackbarCubit.showWithUndo(context, "Gasto eliminado", () {
              billsBloc.add(RestoreExpenseRequested(state.deletedExpenseData));
            });
          }
        },
        child: BlocBuilder<PageManagerCubit, int>(
          builder: (context, state) {
            return state == 0 ? const Bills() : const Categories();
          },
        ),
      ),
    );
  }
}
