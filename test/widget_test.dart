import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmu/main.dart';

void main() {
  testWidgets('На экране есть карточки с картинками и текстом', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Книжная полка'), findsOneWidget);
    expect(find.text('Dart в действии'), findsOneWidget);
    expect(find.byType(Card), findsWidgets);
    expect(find.byType(Image), findsWidgets);
  });
}
