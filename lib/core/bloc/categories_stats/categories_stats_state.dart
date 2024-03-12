part of 'categories_stats_cubit.dart';

sealed class CategoriesStatsState {}

final class CategoriesStatsInitial extends CategoriesStatsState {}

final class CategoriesStatsSectionsRetrieved extends CategoriesStatsState {
  List<PieChartSectionData> sections;
  CategoriesStatsSectionsRetrieved(this.sections);
}
