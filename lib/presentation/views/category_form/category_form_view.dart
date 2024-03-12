import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/color_picker/color_picker_cubit.dart';
import 'package:pollux_test/core/bloc/input_capture/input_capture_cubit.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/bloc/snackbar/snackbar_cubit.dart';
import 'package:pollux_test/core/data/enums/snackbar_type_enum.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_input_widget.dart';
import 'package:pollux_test/presentation/widgets/app/custom_appbar_widget.dart';
import 'package:pollux_test/presentation/widgets/app/custom_elevated_button_widget.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key, this.categoryData});
  final ExpenseCategory? categoryData;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    final snackbarCubit = BlocProvider.of<SnackbarCubit>(context);
    final navigatorCubit = BlocProvider.of<NavigatorCubit>(context);
    final colorPickerCubit = BlocProvider.of<ColorPickerCubit>(context);
    final inputCaptureCubit = BlocProvider.of<InputCaptureCubit>(context);

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
            final message = state.recreated
                ? "Categoría restaurada"
                : "Categoría creada exitosamente";
            snackbarCubit.show(context, message, SnackbarType.success);
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
                  child: Column(
                    children: [
                      CustomInput(
                        defaultValue: categoryData?.name ?? "",
                        label: "Nombre",
                        inputName: "name",
                        placeholder: "Subscripciones",
                        validator: (data) =>
                            data!.isEmpty ? "El nombre es requerido" : null,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                            onPressed: () => colorPickerCubit
                                    .showColorPicker(context, (color) {
                                  inputCaptureCubit.state["color"] = color?.value;
                                }),
                            child: const Row(
                              children: [
                                Icon(Icons.color_lens),
                                Text("Elegir color"),
                              ],
                            )),
                      ),
                      BlocBuilder<InputCaptureCubit, Map<String, dynamic>>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                            title: categoryData != null
                                ? "Editar categoría"
                                : "Añadir categoría",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (state["color"] == null) {
                                  snackbarCubit.show(context,
                                      "Especifica un color", SnackbarType.error);
                                } else {
                                  categoryData != null
                                      ? categoryBloc.add(EditCategoryRequested(
                                          categoryData!.id!, state, categoryData!))
                                      : categoryBloc
                                          .add(CreateCategoryRequested(state));
                                }
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
      ),
    );
  }
}
