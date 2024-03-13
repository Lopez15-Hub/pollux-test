import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/input_capture/input_capture_cubit.dart';
import 'package:pollux_test/core/bloc/snackbar/snackbar_cubit.dart';
import 'package:pollux_test/core/data/enums/snackbar_type_enum.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_elevated_button_widget.dart';

class CategorySubmitButton extends StatelessWidget {
  const CategorySubmitButton({
    super.key,
    required this.categoryData,
    required this.formKey,
    required this.categoryBloc,
  });

  final ExpenseCategory? categoryData;
  final GlobalKey<FormState> formKey;
  final CategoryBloc categoryBloc;

  @override
  Widget build(BuildContext context) {
    final snackbarCubit = BlocProvider.of<SnackbarCubit>(context);

    return BlocBuilder<InputCaptureCubit, Map<String, dynamic>>(
      builder: (context, state) {
        return CustomElevatedButton(
          title: categoryData != null ? "Editar categoría" : "Añadir categoría",
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (state["color"] == null) {
                snackbarCubit.show(
                    context, "Especifica un color", SnackbarType.error);
              } else {
                categoryData != null
                    ? categoryBloc.add(EditCategoryRequested(
                        categoryData!.id!, state, categoryData!))
                    : categoryBloc.add(CreateCategoryRequested(state));
              }
            }
          },
        );
      },
    );
  }
}
