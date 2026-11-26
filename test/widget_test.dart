import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmu/data/course_repository.dart';
import 'package:pmu/main.dart';
import 'package:pmu/models/course_dto.dart';

class _FakeCourseRepository implements CourseRepository {
  _FakeCourseRepository(this.courses);

  final List<CourseDto> courses;
  String lastQuery = '';

  @override
  Future<CoursePageDto> searchCourses({
    required String query,
    int page = 1,
    int size = 20,
  }) async {
    lastQuery = query;
    final normalized = query.toLowerCase();
    final filtered = courses
        .where(
          (CourseDto course) => course.title.toLowerCase().contains(normalized),
        )
        .toList();
    return CoursePageDto(data: filtered, pages: 1, items: filtered.length);
  }
}

void main() {
  const courses = <CourseDto>[
    CourseDto(
      id: '1',
      title: 'Английский для начинающих',
      level: 'A1',
      durationWeeks: 12,
      categoryId: '1',
      teacherId: '1',
      price: 12900,
    ),
    CourseDto(
      id: '2',
      title: 'Испанский с носителем',
      level: 'A2',
      durationWeeks: 10,
      categoryId: '2',
      teacherId: '2',
      price: 11900,
    ),
  ];

  testWidgets('Поиск курсов отправляет запрос и показывает результат', (
    WidgetTester tester,
  ) async {
    final repository = _FakeCourseRepository(courses);

    await tester.pumpWidget(PmuApp(courseRepository: repository));
    await tester.pumpAndSettle();

    expect(find.text('Каталог курсов'), findsOneWidget);
    expect(find.text('Английский для начинающих'), findsOneWidget);
    expect(find.text('Испанский с носителем'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Англ');
    await tester.tap(find.text('Найти'));
    await tester.pumpAndSettle();

    expect(repository.lastQuery, 'Англ');
    expect(find.text('Английский для начинающих'), findsOneWidget);
    expect(find.text('Испанский с носителем'), findsNothing);
  });
}
