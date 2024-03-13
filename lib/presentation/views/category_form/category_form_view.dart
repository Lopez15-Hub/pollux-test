import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/bloc/snackbar/snackbar_cubit.dart';
import 'package:pollux_test/core/data/enums/snackbar_type_enum.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_appbar_widget.dart';
import 'package:pollux_test/presentation/widgets/category_form/category_form_input_group_widget.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key, this.categoryData});
  final ExpenseCategory? categoryData;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final snackbarCubit = BlocProvider.of<SnackbarCubit>(context);
    final navigatorCubit = BlocProvider.of<NavigatorCubit>(context);

    return Scaffold(
      appBar: const CustomAppbar(),
      body: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryUpdated) {
            snackbarCubit.show(
                context, "Categoría actualizada", SnackbarType.success);
            navigatorCubit.pop(context);
          }
          if (state is CategoryCreated) {
            snackbarCubit.show(
                context,
                state.recreated
                    ? "Categoría restaurada"
                    : "Categoría creada exitosamente",
                SnackbarType.success);
            navigatorCubit.pop(context);
          }
          if (state is CategoryError) {
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
                    "Añadir nueva categoría",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Form(
                  key: formKey,
                  child: CategoryFormInputGroup(
                      categoryData: categoryData, formKey: formKey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
