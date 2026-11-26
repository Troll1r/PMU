import '../core/api_client.dart';
import '../core/api_config.dart';
import '../models/course_dto.dart';
import 'course_repository.dart';

/// Реализация репозитория через REST API бэкенда по интернет-программированию.
class HttpCourseRepository implements CourseRepository {
  HttpCourseRepository(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<CoursePageDto> searchCourses({
    required String query,
    int page = 1,
    int size = 20,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/courses').replace(
      queryParameters: <String, String>{
        'page': '$page',
        'size': '$size',
        if (query.trim().isNotEmpty) 'search': query.trim(),
      },
    );

    final json = await _apiClient.getJson(uri);
    return CoursePageDto.fromJson(json);
  }
}
