import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.entries,
      this.onChanged,
      required this.label,
      required this.currentValue});
  final String label;
  final List<DropdownMenuItem<T>> entries;
  final void Function(T?)? onChanged;
  final T currentValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black54),
        ),
        
        child: DropdownButton<T>(
          isExpanded: true,
          items: entries,
          value: currentValue,
          onChanged: onChanged,
          underline: Container(), // Elimina la línea de abajo del Dropdown
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 32,
        ));
  }
}
