import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/page_manager/page_manager_cubit.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppbar({super.key}) : preferredSize = const Size.fromHeight(56.0);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: BlocBuilder<PageManagerCubit, int>(
        builder: (context, state) {
          return Text(state == 0 ? "Mis gastos" : "Categorias");
        },
      ),
      automaticallyImplyLeading: true,
    );
  }
}
