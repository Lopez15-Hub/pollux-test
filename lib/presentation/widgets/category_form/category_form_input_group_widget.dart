import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_input_widget.dart';
import 'package:pollux_test/presentation/widgets/category_form/category_submit_button_widget.dart';
import 'package:pollux_test/presentation/widgets/category_form/color_picker_button_widget.dart';

class CategoryFormInputGroup extends StatelessWidget {
  const CategoryFormInputGroup({
    super.key,
    required this.categoryData,
    required this.formKey,
  });

  final ExpenseCategory? categoryData;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
        final categoryBloc = BlocProvider.of<CategoryBloc>(context);

    return Column(
      children: [
        CustomInput(
          defaultValue: categoryData?.name ?? "",
          label: "Nombre",
          inputName: "name",
          placeholder: "Subscripciones",
          validator: (data) => data!.isEmpty ? "El nombre es requerido" : null,
        ),
        const ColorPickerButton(),
        CategorySubmitButton(
            categoryData: categoryData,
            formKey: formKey,
            categoryBloc: categoryBloc)
      ],
    );
  }
}
