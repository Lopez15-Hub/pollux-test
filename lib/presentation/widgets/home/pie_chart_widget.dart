import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollux_test/core/bloc/categories_stats/categories_stats_cubit.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';
import 'package:pollux_test/presentation/widgets/app/custom_loading_indicator_widget.dart';

class BillsPieChart extends StatelessWidget {
  const BillsPieChart({super.key, required this.bills});

  final List<ExpenseResponse> bills;

  @override
  Widget build(BuildContext context) {
    final categoriesStatsCubit = BlocProvider.of<CategoriesStatsCubit>(context);
    categoriesStatsCubit.getStats(bills);
    return BlocBuilder<CategoriesStatsCubit, CategoriesStatsState>(
      builder: (context, state) {
        if (state is CategoriesStatsSectionsRetrieved) {
          return AspectRatio(
            aspectRatio: 2,
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 1,
                centerSpaceRadius: 0,
                sections: state.sections,
              ),
            ),
          );
        }
        return const CustomLoadingIndicator();
      },
    );
  }
}
