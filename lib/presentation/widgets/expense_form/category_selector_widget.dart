import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/input_capture/input_capture_cubit.dart';
import 'package:pollux_test/presentation/widgets/app/custom_loading_indicator_widget.dart';
import 'package:pollux_test/presentation/widgets/expense_form/custom_dropdown_widget.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    this.defaultValue = "null",
  });
  final String? defaultValue;
  @override
  Widget build(BuildContext context) {
    final inputCaptureCubit = BlocProvider.of<InputCaptureCubit>(context);
    inputCaptureCubit.record("category", defaultValue ?? "null");
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoriesEmpty) {
            return const Center(
              child: Text("No tienes categorías creadas"),
            );
          }
          if (state is CategoriesRetrieved) {
            return BlocBuilder<InputCaptureCubit, Map<String, dynamic>>(
              builder: (context, inputCaptureState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Categoría",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 18),
                    ),
                    CustomDropdown(
                        label: "Categoría",
                        onChanged: (value) =>
                            inputCaptureCubit.record("category", value),
                        currentValue:
                            defaultValue ?? inputCaptureState["category"],
                        entries: [
                          const DropdownMenuItem(
                            value: "null",
                            child: Text("Sin categoría"),
                          ),
                          ...state.categories
                              .map((category) => DropdownMenuItem(
                                    value: category.id.toString(),
                                    child: Text(category.name),
                                  ))
                        ]),
                  ],
                );
              },
            );
          }
          return const CustomLoadingIndicator();
        },
      ),
    );
  }
}
