import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/presentation/views/category_form/category_form_view.dart';
import 'package:pollux_test/presentation/widgets/app/no_data_widget.dart';
import 'package:pollux_test/presentation/widgets/categories/categories_list_widget.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    final navigatorCubit = BlocProvider.of<NavigatorCubit>(context);

    categoryBloc.add(ReadCategoriesRequested());
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoriesEmpty) {
          return NoData(
            message: "No tenés categorías creadas",
            action: () =>
                navigatorCubit.pushWidget(context, const CategoryForm()),
          );
        }
        if (state is CategoryError) {
          return Center(
            child: Text(
              state.reason,
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state is CategoriesRetrieved) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: CategoriesList(categories: state.categories),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
