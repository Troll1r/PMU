import '../models/course_dto.dart';

/// Интерфейс репозитория курсов.
abstract interface class CourseRepository {
  /// Ищет курсы по названию. Пустой [query] возвращает первую страницу.
  Future<CoursePageDto> searchCourses({
    required String query,
    int page = 1,
    int size = 20,
  });
}
