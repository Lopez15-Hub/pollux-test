import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/page_manager/page_manager_cubit.dart';

class CustomBottombar extends StatelessWidget {
  const CustomBottombar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<PageManagerCubit, int>(
      builder: (context, state) {
        return BottomNavigationBar(currentIndex: state,
        onTap: (index)=>context.read<PageManagerCubit>().changePage(index),
         items: const [
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categorias"),
        ]);
      },
    );
  }
}
