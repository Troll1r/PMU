import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmu/main.dart';

void main() {
  testWidgets('Показывает три карточки как в лекции', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter is gorgeous'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(3));
    expect(find.byType(Image), findsNWidgets(3));
    expect(find.text('Dart в действии'), findsOneWidget);
    expect(find.text('Чистый код'), findsOneWidget);
    expect(find.text('Властелин колец'), findsOneWidget);
  });
}
