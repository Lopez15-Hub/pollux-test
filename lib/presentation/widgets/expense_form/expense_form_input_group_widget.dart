import 'package:flutter/material.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_input_widget.dart';
import 'package:pollux_test/presentation/widgets/expense_form/category_selector_widget.dart';
import 'package:pollux_test/presentation/widgets/expense_form/submit_expense_button_widget.dart';

class ExpenseFormInputGroup extends StatelessWidget {
  const ExpenseFormInputGroup(
      {super.key, this.expenseData, required this.formKey});
  final ExpenseResponse? expenseData;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInput(
          defaultValue: expenseData?.description ?? "",
          label: "Descripción",
          inputName: "description",
          placeholder: "Netflix",
          validator: (data) =>
              data!.isEmpty ? "La descripción es requerida" : null,
        ),
        CategorySelector(defaultValue: expenseData?.category.id.toString()),
        CustomInput(
          type: TextInputType.number,
          defaultValue: expenseData?.amount.toString() ?? "",
          label: "Monto",
          inputName: "amount",
          placeholder: "4.200",
          validator: (data) => data!.isEmpty ? "Especifique un precio" : null,
        ),
        SubmitExpenseButton(
          expenseData: expenseData,
          formKey: formKey,
        )
      ],
    );
  }
}
