import 'package:flutter/material.dart';

import '../core/api_client.dart';
import '../data/course_repository.dart';
import '../models/course_dto.dart';

/// Экран поиска курсов по REST API (лабораторная работа №5).
class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key, required this.repository});

  final CourseRepository repository;

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<CoursePageDto> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = _load('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<CoursePageDto> _load(String query) {
    return widget.repository.searchCourses(query: query, size: 50);
  }

  void _search() {
    FocusScope.of(context).unfocus();
    final query = _searchController.text.trim();
    setState(() {
      _coursesFuture = _load(query);
    });
  }

  void _resetSearch() {
    _searchController.clear();
    _search();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Каталог курсов'),
            Text(
              'Кирюшин А.П. ПИбд-32',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _search(),
                    decoration: InputDecoration(
                      hintText: 'Поиск по названию курса',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _search,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Найти'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<CoursePageDto>(
              future: _coursesFuture,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<CoursePageDto> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return _ErrorView(
                        message: _errorMessage(snapshot.error),
                        onRetry: _search,
                      );
                    }

                    final page = snapshot.data;
                    if (page == null || page.data.isEmpty) {
                      return _EmptyView(onReset: _resetSearch);
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                          child: Text(
                            'Найдено: ${page.items}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            itemCount: page.data.length,
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) => const SizedBox(height: 10),
                            itemBuilder: (BuildContext context, int index) =>
                                _CourseCard(course: page.data[index]),
                          ),
                        ),
                      ],
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }

  String _errorMessage(Object? error) {
    if (error is ApiException) {
      return error.message;
    }
    return 'Не удалось получить данные. Проверь, что бэкенд запущен '
        'на порту 3001, и повтори попытку.';
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});

  final CourseDto course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                course.level,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    course.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${course.durationWeeks} недель · уровень ${course.level}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatPrice(course.price),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    final digits = price.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }
    return '$buffer ₽';
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.cloud_off_rounded,
              size: 56,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              'Не удалось загрузить курсы',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: onRetry,
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.search_off_rounded,
              size: 56,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Ничего не найдено',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Попробуй другое название курса.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: onReset,
              child: const Text('Сбросить поиск'),
            ),
          ],
        ),
      ),
    );
  }
}
