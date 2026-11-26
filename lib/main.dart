// Лабораторная работа №3. Список карточек.
//
// Вся лабораторная написана в этом одном файле, чтобы было проще.
// На экране — список карточек, в каждой есть картинка и текст.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ПМУ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const BooksPage(),
    );
  }
}

class Book {
  const Book({
    required this.title,
    required this.author,
    required this.image,
    required this.description,
  });

  final String title;
  final String author;
  final String image;
  final String description;
}

const List<Book> books = <Book>[
  Book(
    title: 'Dart в действии',
    author: 'Эрик Фриман',
    image: 'assets/images/dart_in_action.png',
    description: 'Практическое руководство по современному Dart.',
  ),
  Book(
    title: 'Чистый код',
    author: 'Роберт Мартин',
    image: 'assets/images/clean_code.png',
    description: 'Как писать понятный и поддерживаемый код.',
  ),
  Book(
    title: 'Краткая история времени',
    author: 'Стивен Хокинг',
    image: 'assets/images/brief_history_of_time.png',
    description: 'От Большого взрыва до чёрных дыр.',
  ),
  Book(
    title: 'Властелин колец',
    author: 'Дж. Р. Р. Толкин',
    image: 'assets/images/lotr.png',
    description: 'История о хоббитах, Кольце и Средиземье.',
  ),
  Book(
    title: 'История России',
    author: 'А. С. Орлов',
    image: 'assets/images/russian_history.png',
    description: 'Основные события и личности отечественной истории.',
  ),
];

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Книжная полка'),
            Text(
              'Кирюшин А.П. ПИбд-32',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          final book = books[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            clipBehavior: Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  book.image,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          book.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book.author,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
