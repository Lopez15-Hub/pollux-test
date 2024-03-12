import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/input_capture/input_capture_cubit.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      this.type = TextInputType.text,
      this.placeholder = "",
      this.errorMessage = "",
      this.defaultValue = "",
      this.validator,
      this.onChanged,
      required this.inputName,
      required this.label});
  final String? placeholder;
  final String label;
  final String defaultValue;
  final String? errorMessage;
  final String inputName;
  final String? Function(String?)? validator;
  final TextInputType type;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final inputCaptureCubit = BlocProvider.of<InputCaptureCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,textAlign: TextAlign.start,style: const TextStyle(fontSize: 18),),
          TextFormField(
            controller: TextEditingController(text: defaultValue),
            validator: validator,
            keyboardType: type,
            
            onChanged: (value) => inputCaptureCubit.record(inputName, value),
            autovalidateMode: AutovalidateMode.disabled,
            decoration: InputDecoration(
              hintText: placeholder,
              errorText: errorMessage!.isEmpty ? null : errorMessage,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide:
                      BorderSide(color: Color.fromRGBO(49, 27, 146, 1))),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
