import 'package:flutter/material.dart';
import 'package:pollux_test/presentation/widgets/app/custom_elevated_button_widget.dart';

class NoData extends StatelessWidget {
  const NoData({super.key, required this.message, this.action});
  final String message;
  final void Function()? action;

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                        "assets/no_data.jpg",
                        width: 200,
                        height: 200,
                      ),
            )),
         Padding(
          padding:const EdgeInsets.all(10),
          child: Text(
            message,
            style:const TextStyle(fontSize: 22),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: CustomElevatedButton(
            title: "Añadir",
            onPressed: action,
          ),
        )
      ],
    );
  }
}
