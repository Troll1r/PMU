// Лабораторная работа №3. Карточки как в лекции.
//
// Всё в одном файле:
// - три карточки в Column;
// - у каждой карточки картинка, заголовок, описание и иконка;
// - карточки оранжевые, как в видео.
//
// В видео картинки загружаются по URL через Image.network.
// Здесь картинки лежат в assets/images, чтобы всё работало без интернета.

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
    required this.icon,
    required this.imagePath,
  });

  final String title;
  final String descriptionText;
  final IconData icon;
  final String imagePath;
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = <_CardData>[
      const _CardData(
        'Dart в действии',
        'Эрик Фриман',
        icon: Icons.code,
        imagePath: 'assets/images/dart_in_action.png',
      ),
      const _CardData(
        'Чистый код',
        'Роберт Мартин',
        icon: Icons.check_circle_outline,
        imagePath: 'assets/images/clean_code.png',
      ),
      const _CardData(
        'Властелин колец',
        'Дж. Р. Р. Толкин',
        icon: Icons.auto_awesome,
        imagePath: 'assets/images/lotr.png',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: data.map((item) => _Card(data: item)).toList(),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.data});

  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            Icon(data.icon, size: 20, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
