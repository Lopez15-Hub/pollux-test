import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/snackbar/snackbar_cubit.dart';
import 'package:pollux_test/core/data/enums/snackbar_type_enum.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/presentation/widgets/categories/category_item_widget.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.categories});
  final List<ExpenseCategory> categories;
  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    final snackbarCubit = BlocProvider.of<SnackbarCubit>(context);
    return BlocListener<BillsBloc, BillsState>(
      listener: (context, state) {
        if (state is BillsRemoved) {
          categoryBloc.add(DeleteCategoryRequested(state.category));
          snackbarCubit.renderSnackbar(
              context, "Categoría eliminada", SnackbarType.success);
        }
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) =>
            CategoryItem(category: categories[index]),
      ),
    );
  }
}
