import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pollux_test/pollux_test.dart';
import 'package:pollux_test/presentation/widgets/app/custom_input_widget.dart';

navigateToCategoriesView(tester) async {
  await tester.pumpWidget(const PolluxTest());

  final fab = find.byType(FloatingActionButton);
  final categoryIcon = find.byIcon(Icons.category);
  await tester.pumpAndSettle();
  await tester.tap(categoryIcon);
  await tester.pumpAndSettle();
  expect(fab, findsOneWidget);
}

navigateToCategoriesForm(tester) async {
  await navigateToCategoriesView(tester);

  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  final searchText = find.text("Añadir categoría");
  expect(searchText, findsOneWidget);
}

void main() {
  group("0000_test_bottom_bar_navigation", () {
    testWidgets("Test if user can navigate to categories using bottombar",
        (WidgetTester tester) async => navigateToCategoriesView(tester));
  });
  group("0001_test_category_creation_form", () {
    testWidgets("Test if i can wrote on input", (WidgetTester tester) async {
      await navigateToCategoriesForm(tester);
      const category = "Gastos Innecesarios";
      final customInput = find.byType(CustomInput);
      await tester.tap(customInput);
      await tester.enterText(customInput, category);
      await tester.pumpAndSettle();
    });
  });
}
