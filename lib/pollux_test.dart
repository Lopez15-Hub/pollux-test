import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/bills/bills_bloc.dart';
import 'package:pollux_test/core/bloc/categories_stats/categories_stats_cubit.dart';
import 'package:pollux_test/core/bloc/category/category_bloc.dart';
import 'package:pollux_test/core/bloc/color_picker/color_picker_cubit.dart';
import 'package:pollux_test/core/bloc/input_capture/input_capture_cubit.dart';
import 'package:pollux_test/core/bloc/navigator/navigator_cubit.dart';
import 'package:pollux_test/core/bloc/page_manager/page_manager_cubit.dart';
import 'package:pollux_test/core/bloc/snackbar/snackbar_cubit.dart';
import 'package:pollux_test/core/data/repositories/category_repository.dart';
import 'package:pollux_test/core/data/repositories/expense_repository.dart';
import 'package:pollux_test/presentation/views/home/home_view.dart';

class PolluxTest extends StatelessWidget {
  const PolluxTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigatorCubit()),
        BlocProvider(create: (context) => InputCaptureCubit()),
        BlocProvider(create: (context) => SnackbarCubit()),
        BlocProvider(create: (context) => ColorPickerCubit()),
        BlocProvider(create: (context) => PageManagerCubit()),
        BlocProvider(create: (context) => CategoriesStatsCubit()),
        BlocProvider(create: (context) => BillsBloc(ExpenseRepository(), CategoryRepository())),
        BlocProvider(create: (context) => CategoryBloc(CategoryRepository())),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(
          useMaterial3: true
        ),
        home: const Home(),
      ),
    );
  }
}
