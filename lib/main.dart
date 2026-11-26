// Лабораторная работа №4. Лайки, SnackBar и детали.
//
// Стиль карточек — как в лекции: оранжевые карточки с книгой.
// Добавлено:
// - сердечко для лайка;
// - SnackBar при нажатии;
// - экран с деталями при нажатии на карточку.
//
// Всё в одном файле.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          title: const Text('Flutter is gorgeous'),
        ),
        body: const MyWidget(),
      ),
    );
  }
}

class _CardData {
  const _CardData(
    this.title,
    this.descriptionText, {
    required this.imagePath,
    required this.details,
  });

  final String title;
  final String descriptionText;
  final String imagePath;
  final String details;
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  static const List<_CardData> _data = <_CardData>[
    _CardData(
      'Dart в действии',
      'Эрик Фриман',
      imagePath: 'assets/images/dart_in_action.png',
      details:
          'Практическое руководство по современному Dart: '
          'коллекции, асинхронность и тесты.',
    ),
    _CardData(
      'Чистый код',
      'Роберт Мартин',
      imagePath: 'assets/images/clean_code.png',
      details:
          'Принципы написания понятного, поддерживаемого и надёжного кода.',
    ),
    _CardData(
      'Властелин колец',
      'Дж. Р. Р. Толкин',
      imagePath: 'assets/images/lotr.png',
      details: 'Эпическая история о хоббитах, Кольце Всевластия и Средиземье.',
    ),
  ];

  final Set<int> _liked = <int>{};

  void _toggleLike(int index) {
    setState(() {
      if (!_liked.add(index)) {
        _liked.remove(index);
      }
    });

    final isLiked = _liked.contains(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isLiked ? 'Лайк поставлен' : 'Лайк убран'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _openDetails(_CardData data) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => _BookDetailsPage(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (var i = 0; i < _data.length; i++)
            _Card(
              data: _data[i],
              isLiked: _liked.contains(i),
              onLike: () => _toggleLike(i),
              onTap: () => _openDetails(_data[i]),
            ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.data,
    required this.isLiked,
    required this.onLike,
    required this.onTap,
  });

  final _CardData data;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  data.imagePath,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.title,
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    Text(
                      data.descriptionText,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: isLiked ? 'Убрать лайк' : 'Поставить лайк',
                onPressed: onLike,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookDetailsPage extends StatelessWidget {
  const _BookDetailsPage({required this.data});

  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        title: Text(data.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Image.asset(data.imagePath, height: 300, fit: BoxFit.contain),
          const SizedBox(height: 16),
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            data.descriptionText,
            style: TextStyle(fontSize: 18, color: Colors.grey[800]),
          ),
          const SizedBox(height: 16),
          Text(data.details, style: const TextStyle(fontSize: 16, height: 1.4)),
        ],
      ),
    );
  }
}
