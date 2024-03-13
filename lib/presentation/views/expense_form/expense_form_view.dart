import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/bloc/snackbar/snackbar_cubit.dart';
import 'package:pollux_test/core/data/enums/snackbar_type_enum.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_appbar_widget.dart';
import 'package:pollux_test/presentation/widgets/expense_form/expense_form_input_group_widget.dart';

class ExpenseForm extends StatelessWidget {
  const ExpenseForm({super.key, this.expenseData});
  final ExpenseResponse? expenseData;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    final snackbarCubit = BlocProvider.of<SnackbarCubit>(context);
    final navigatorCubit = BlocProvider.of<NavigatorCubit>(context);
    categoryBloc.add(ReadCategoriesRequested());
    return Scaffold(
      appBar: const CustomAppbar(),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return BlocListener<BillsBloc, BillsState>(
            listener: (context, state) {
              if (state is ExpenseUpdated) {
                snackbarCubit.show(
                    context, "Gasto actualizado", SnackbarType.success);
                navigatorCubit.pop(context);
              }
              if (state is ExpenseCreated) {
                final message = state.recreated
                    ? "Gasto restaurado"
                    : "Gasto creado exitosamente";
                snackbarCubit.show(context, message, SnackbarType.success);
                navigatorCubit.pop(context);
              }
              if (state is BillsError) {
                snackbarCubit.show(context, state.reason, SnackbarType.error);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Añadir un nuevo gasto",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: ExpenseFormInputGroup(
                          expenseData: expenseData, formKey: formKey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
