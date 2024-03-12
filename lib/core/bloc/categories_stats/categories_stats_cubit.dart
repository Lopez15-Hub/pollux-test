import 'package:bloc/bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pollux_test/core/data/models/expense_response_model.dart';

part 'categories_stats_state.dart';

class CategoriesStatsCubit extends Cubit<CategoriesStatsState> {
  CategoriesStatsCubit() : super(CategoriesStatsInitial());

  getStats(List<ExpenseResponse> bills) {
    final categoryCounts = <String, int>{};

    for (final bill in bills) {
      final category = bill.category;
      if (categoryCounts.containsKey(category.name)) {
        categoryCounts[category.name] = categoryCounts[category.name]! + 1;
      } else {
        categoryCounts[category.name] = 1;
      }
    }

    final List<PieChartSectionData> sections = [];

    final defaultColors = [
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.green,
    ];

    int defaultColorIndex = 0;

    categoryCounts.forEach((category, count) {
      final matchingBills =
          bills.where((bill) => bill.category.name == category).toList();
      Color categoryColor;

      if (matchingBills.isNotEmpty &&
          matchingBills.first.category.color.isNaN) {
        categoryColor = Color(matchingBills.first.category.color);
      } else {
        categoryColor = defaultColors[defaultColorIndex];
        defaultColorIndex = (defaultColorIndex + 1) % defaultColors.length;
      }

      sections.add(
        PieChartSectionData(
          color: categoryColor,
          value: count.toDouble(),
          title: category,
          radius: 70,
          titlePositionPercentageOffset: 0.55,
        ),
      );
    });
    emit(CategoriesStatsSectionsRetrieved(sections));
  }
}
