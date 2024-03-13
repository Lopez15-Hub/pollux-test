import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/color_picker/color_picker_cubit.dart';
import 'package:pollux_test/core/bloc/input_capture/input_capture_cubit.dart';

class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorPickerCubit = BlocProvider.of<ColorPickerCubit>(context);
    final inputCaptureCubit = BlocProvider.of<InputCaptureCubit>(context);

    return BlocBuilder<InputCaptureCubit, Map<String, dynamic>>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: state["color"] != null
                        ? Color(int.parse(state["color"]))
                        : Colors.transparent),
                onPressed: () =>
                    colorPickerCubit.showColorPicker(context, (color) {
                  inputCaptureCubit.record("color", color!.value.toString());
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.color_lens),
                    Text(state["color"] != null
                        ? "R: ${Color(int.parse(state["color"])).red} G:${Color(int.parse(state["color"])).green} B:${Color(int.parse(state["color"])).blue}"
                        : "Elegir color"),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
