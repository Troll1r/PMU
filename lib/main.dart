// Лабораторная работа №2. Основы Dart.
// Запуск: dart run lib/main.dart
//
// В этом файле специально всё написано просто и в одном месте.
// Используются: класс, enum, циклы, generics, анонимные функции,
// Future и extension.
//
// ignore_for_file: avoid_print

enum Genre { fantasy, science, programming }

class Book {
  Book(this.title, this.author, this.year, this.genre, {this.isRead = false});

  final String title;
  final String author;
  final int year;
  final Genre genre;
  bool isRead;

  void read() {
    isRead = true;
  }

  @override
  String toString() {
    final status = isRead ? 'прочитана' : 'не прочитана';
    return '$title — $author ($year), ${genre.name}, $status';
  }
}

// Generics: коробка может хранить что угодно.
class Box<T> {
  final List<T> items = <T>[];

  void add(T item) {
    items.add(item);
  }

  List<T> where(bool Function(T) test) {
    return items.where(test).toList();
  }
}

// Extension: добавляем статистику к обычному списку книг.
extension BookStats on List<Book> {
  int get readCount {
    var count = 0;
    for (final book in this) {
      if (book.isRead) {
        count++;
      }
    }
    return count;
  }

  double get averageYear {
    var sum = 0;
    for (final book in this) {
      sum += book.year;
    }
    return sum / length;
  }
}

// Future: имитация загрузки данных с сервера.
Future<List<Book>> loadBooks() async {
  await Future<void>.delayed(const Duration(milliseconds: 300));
  return <Book>[
    Book('Dart в действии', 'Эрик Фриман', 2022, Genre.programming),
    Book('Чистый код', 'Роберт Мартин', 2008, Genre.programming, isRead: true),
    Book(
      'Властелин колец',
      'Дж. Р. Р. Толкин',
      1954,
      Genre.fantasy,
      isRead: true,
    ),
    Book('Краткая история времени', 'Стивен Хокинг', 1988, Genre.science),
  ];
}

Future<void> main() async {
  final books = await loadBooks();

  final box = Box<Book>();
  for (final book in books) {
    box.add(book);
  }

  print('Всего книг: ${box.items.length}');
  print('Прочитано: ${books.readCount}');
  print('Средний год: ${books.averageYear.toStringAsFixed(1)}');

  // Анонимная функция внутри where.
  final unread = box.where((book) => !book.isRead);
  print('\nНе прочитано:');
  for (final book in unread) {
    print('  $book');
  }

  // Метод класса меняет состояние объекта.
  books.first.read();
  print('\nПосле чтения: ${books.first}');

  // Анонимная функция внутри map.
  final years = books.map((book) => book.year).toList();
  print('Годы изданий: $years');

  // Обычный цикл while.
  var index = 0;
  while (index < 2) {
    print('Книга ${index + 1}: ${books[index].title}');
    index++;
  }
}
