import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmu/main.dart';

void main() {
  testWidgets('На экране отображается список карточек книг', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PmuApp());
    await tester.pumpAndSettle();

    expect(find.text('Книжная полка'), findsOneWidget);
    expect(find.text('Кирюшин А.П. ПИбд-32'), findsOneWidget);
    expect(find.text('Dart в действии'), findsOneWidget);
    expect(find.byType(Card), findsWidgets);
    expect(find.byType(Image), findsWidgets);
  });
}
