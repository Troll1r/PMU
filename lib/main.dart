import 'package:flutter/material.dart';

import 'core/api_client.dart';
import 'data/course_repository.dart';
import 'data/http_course_repository.dart';
import 'screens/courses_screen.dart';

void main() {
  final courseRepository = HttpCourseRepository(ApiClient());
  runApp(PmuApp(courseRepository: courseRepository));
}

class PmuApp extends StatelessWidget {
  const PmuApp({super.key, required this.courseRepository});

  final CourseRepository courseRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ПМУ — лабораторные работы',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: CoursesScreen(repository: courseRepository),
    );
  }
}
