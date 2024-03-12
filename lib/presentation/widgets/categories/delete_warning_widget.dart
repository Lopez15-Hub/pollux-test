import 'package:flutter/material.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/data/models/expense_category_model.dart';

class DeleteWarning extends StatelessWidget {
  const DeleteWarning({
    super.key,
    required this.navigatorCubit,
    required this.category,
    this.onCancel,
  });

  final NavigatorCubit navigatorCubit;
  final ExpenseCategory category;
  final Function(bool cancel)? onCancel;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("¿Estás seguro?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Eliminar"))
      ],
      content: const Text(
          "Se borrará la categoría y todos sus gastos. Esta acción es irreversible"),
    );
  }
}
