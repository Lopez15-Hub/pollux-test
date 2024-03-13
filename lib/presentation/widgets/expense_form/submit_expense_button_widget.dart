import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/input_capture/input_capture_cubit.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_elevated_button_widget.dart';

class SubmitExpenseButton extends StatelessWidget {
  const SubmitExpenseButton({
    super.key,
    required this.expenseData,
    required this.formKey,
  });

  final ExpenseResponse? expenseData;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final billsBloc = BlocProvider.of<BillsBloc>(context);

    return BlocBuilder<InputCaptureCubit, Map<String, dynamic>>(
      builder: (context, state) {
        return CustomElevatedButton(
          title: expenseData != null ? "Editar gasto" : "Añadir gasto",
          onPressed: () {
            if (formKey.currentState!.validate()) {
              expenseData != null
                  ? billsBloc.add(EditExpenseRequested(
                      expenseData!.id, state, expenseData!))
                  : billsBloc.add(CreateExpenseRequested(state));
            }
          },
        );
      },
    );
  }
}
