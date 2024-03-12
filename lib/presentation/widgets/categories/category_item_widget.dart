import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';
import 'package:pollux_test/presentation/views/category_form/category_form_view.dart';
import 'package:pollux_test/presentation/widgets/categories/delete_warning_widget.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});
  final ExpenseCategory category;
  @override
  Widget build(BuildContext context) {
    final navigatorCubit = BlocProvider.of<NavigatorCubit>(context);
    final billsBloc = BlocProvider.of<BillsBloc>(context);

    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      key: Key(category.id.toString()),
      confirmDismiss: (direction) async {
        final bool result = await showDialog(
            context: context,
            builder: (context) => DeleteWarning(
                navigatorCubit: navigatorCubit, category: category));

        if (result) {
          billsBloc.add(DeleteBillsByCategoryRequested(category));
        }
        return result;
      },
      child: ListTile(
        onTap: () => navigatorCubit.pushWidget(
            context,
            CategoryForm(
              categoryData: category,
            )),
        leading: const Icon(Icons.monetization_on),
        title: Text(category.name),
        trailing: Icon(
          Icons.tag,
          color: Color(category.color),
        ),
      ),
    );
  }
}
