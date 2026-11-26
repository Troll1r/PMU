/// DTO курса — структура ответа `GET /api/courses`.
class CourseDto {
  const CourseDto({
    required this.id,
    required this.title,
    required this.level,
    required this.durationWeeks,
    required this.categoryId,
    required this.teacherId,
    required this.price,
  });

  final String id;
  final String title;
  final String level;
  final int durationWeeks;
  final String categoryId;
  final String teacherId;
  final int price;

  factory CourseDto.fromJson(Map<String, dynamic> json) {
    return CourseDto(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? 'Без названия',
      level: json['level'] as String? ?? '',
      durationWeeks: (json['durationWeeks'] as num?)?.toInt() ?? 0,
      categoryId: json['categoryId']?.toString() ?? '',
      teacherId: json['teacherId']?.toString() ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
    );
  }
}

/// DTO страницы: `{ data, pages, items }`.
class CoursePageDto {
  const CoursePageDto({
    required this.data,
    required this.pages,
    required this.items,
  });

  final List<CourseDto> data;
  final int pages;
  final int items;

  factory CoursePageDto.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as List<dynamic>? ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(CourseDto.fromJson)
        .toList(growable: false);

    return CoursePageDto(
      data: data,
      pages: (json['pages'] as num?)?.toInt() ?? 0,
      items: (json['items'] as num?)?.toInt() ?? data.length,
    );
  }
}
