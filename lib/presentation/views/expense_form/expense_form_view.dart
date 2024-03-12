import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/input_capture/input_capture_cubit.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/bloc/snackbar/snackbar_cubit.dart';
import 'package:pollux_test/core/data/enums/snackbar_type_enum.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_input_widget.dart';
import 'package:pollux_test/presentation/widgets/app/custom_appbar_widget.dart';
import 'package:pollux_test/presentation/widgets/app/custom_elevated_button_widget.dart';
import 'package:pollux_test/presentation/widgets/expense_form/category_selector_widget.dart';

class ExpenseForm extends StatelessWidget {
  const ExpenseForm({super.key, this.expenseData});
  final ExpenseResponse? expenseData;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final billsBloc = BlocProvider.of<BillsBloc>(context);
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
                      child: Column(
                        children: [
                          CustomInput(
                            defaultValue: expenseData?.description ?? "",
                            label: "Descripción",
                            inputName: "description",
                            placeholder: "Netflix",
                            validator: (data) => data!.isEmpty
                                ? "La descripción es requerida"
                                : null,
                          ),
                          CategorySelector(
                              defaultValue:
                                  expenseData?.category.id.toString()),
                          CustomInput(
                            type: TextInputType.number,
                            defaultValue: expenseData?.amount.toString() ?? "",
                            label: "Monto",
                            inputName: "amount",
                            placeholder: "4.200",
                            validator: (data) =>
                                data!.isEmpty ? "Especifique un precio" : null,
                          ),
                          BlocBuilder<InputCaptureCubit, Map<String, dynamic>>(
                            builder: (context, state) {
                              return CustomElevatedButton(
                                title: expenseData != null
                                    ? "Editar gasto"
                                    : "Añadir gasto",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    expenseData != null
                                        ? billsBloc.add(EditExpenseRequested(
                                            expenseData!.id,
                                            state,
                                            expenseData!))
                                        : billsBloc
                                            .add(CreateExpenseRequested(state));
                                  }
                                },
                              );
                            },
                          )
                        ],
                      ),
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
