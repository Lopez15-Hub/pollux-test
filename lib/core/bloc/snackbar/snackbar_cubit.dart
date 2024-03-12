import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pollux_test/core/data/enums/snackbar_type_enum.dart';

class SnackbarCubit extends Cubit<dynamic> {
  SnackbarCubit() : super(null);

  SnackBar renderSnackbar(
      BuildContext context, String message, SnackbarType type) {
    switch (type) {
      case SnackbarType.error:
        return SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        );
      case SnackbarType.success:
        return SnackBar(
          content: Text(message),
          backgroundColor: Colors.green[800],
        );
    }
  }

  void show(BuildContext context, String message, SnackbarType type) {
    ScaffoldMessenger.of(context)
        .showSnackBar(renderSnackbar(context, message, type));
  }

  void showWithUndo(
      BuildContext context, String message, void Function()? onUndo) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green[800],
      duration: const Duration(seconds: 3),
      action: SnackBarAction(label: "Deshacer", onPressed: onUndo!),
    ));
  }
}
