import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pollux_test/presentation/widgets/category_form/custom_color_picker_widget.dart';

class ColorPickerCubit extends Cubit<dynamic> {
  ColorPickerCubit() : super(null);

  void showColorPicker(
      BuildContext context, void Function(Color?) onChangeColor) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomColorPicker(
            onColorChanged: onChangeColor,
          );
        });
  }
}
