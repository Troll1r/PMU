import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmu/main.dart';

void main() {
  testWidgets('Лайк показывает SnackBar, карточка открывает детали', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Книжная полка'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsWidgets);

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.text('Лайк поставлен'), findsOneWidget);

    // Даём SnackBar исчезнуть, чтобы он не мешал нажать на карточку.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Dart в действии').first);
    await tester.pumpAndSettle();

    expect(find.byType(BookDetailsPage), findsOneWidget);
    expect(find.text('Dart в действии'), findsWidgets);
    expect(find.text('Эрик Фриман'), findsWidgets);
  });
}
