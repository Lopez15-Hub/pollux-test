import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/bloc/page_manager/page_manager_cubit.dart';
import 'package:pollux_test/presentation/views/category_form/category_form_view.dart';
import 'package:pollux_test/presentation/views/expense_form/expense_form_view.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigatorCubit = BlocProvider.of<NavigatorCubit>(context);

    return BlocBuilder<PageManagerCubit, int>(
      builder: (context, pageManagerState) {
        return BlocBuilder<BillsBloc, BillsState>(
          builder: (context, state) {
            return FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => pageManagerState == 0
                  ? navigatorCubit.pushWidget(context, const ExpenseForm())
                  : navigatorCubit.pushWidget(context, const CategoryForm()),
            );
          },
        );
      },
    );
  }
}
