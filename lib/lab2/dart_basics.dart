// Лабораторная работа №2. Знакомство с Dart.
//
// Запуск: dart run lib/lab2/dart_basics.dart
//
// В коде используются:
// - классы с полями и методами (Book, Repository);
// - enum (BookGenre);
// - циклы (for, for-in, while);
// - generics (Repository<T>, List<Book>);
// - анонимные функции (where/map/sort/forEach);
// - Future и async/await (loadBooks, main);
// - extension (BookCollection на Iterable<Book>).
//
// ignore_for_file: avoid_print

/// Жанры книг.
enum BookGenre {
  fantasy('Фэнтези'),
  science('Наука'),
  history('История'),
  programming('Программирование');

  const BookGenre(this.title);

  final String title;
}

/// Книга: класс с полями и методами.
class Book {
  Book({
    required this.title,
    required this.author,
    required this.year,
    required this.genre,
    this.isRead = false,
  });

  final String title;
  final String author;
  final int year;
  final BookGenre genre;
  bool isRead;

  void markAsRead() {
    isRead = true;
  }

  String describe() {
    final status = isRead ? 'прочитана' : 'не прочитана';
    return '«$title» — $author ($year), ${genre.title}, $status';
  }

  @override
  String toString() => describe();
}

/// Обобщённое хранилище (generics).
class Repository<T> {
  final List<T> _items = <T>[];

  List<T> get items => List<T>.unmodifiable(_items);

  int get length => _items.length;

  void add(T item) {
    _items.add(item);
  }

  void addAll(Iterable<T> items) {
    _items.addAll(items);
  }

  List<T> where(bool Function(T) test) {
    final result = <T>[];
    for (final item in _items) {
      if (test(item)) {
        result.add(item);
      }
    }
    return result;
  }

  T? firstWhereOrNull(bool Function(T) test) {
    for (var i = 0; i < _items.length; i++) {
      if (test(_items[i])) {
        return _items[i];
      }
    }
    return null;
  }
}

/// Extension: дополнительная логика для коллекции книг.
extension BookCollection on Iterable<Book> {
  double get averageYear {
    if (isEmpty) {
      return 0;
    }
    var sum = 0;
    for (final book in this) {
      sum += book.year;
    }
    return sum / length;
  }

  Map<BookGenre, List<Book>> groupByGenre() {
    final groups = <BookGenre, List<Book>>{};
    for (final book in this) {
      groups.putIfAbsent(book.genre, () => <Book>[]).add(book);
    }
    return groups;
  }
}

/// Имитация загрузки каталога с сервера: Future + async/await.
Future<List<Book>> loadBooks() async {
  print('Загружаем каталог...');
  await Future<void>.delayed(const Duration(milliseconds: 300));
  return <Book>[
    Book(
      title: 'Dart в действии',
      author: 'Эрик Фриман',
      year: 2022,
      genre: BookGenre.programming,
    ),
    Book(
      title: 'Чистый код',
      author: 'Роберт Мартин',
      year: 2008,
      genre: BookGenre.programming,
      isRead: true,
    ),
    Book(
      title: 'Краткая история времени',
      author: 'Стивен Хокинг',
      year: 1988,
      genre: BookGenre.science,
    ),
    Book(
      title: 'Властелин колец',
      author: 'Джон Толкин',
      year: 1954,
      genre: BookGenre.fantasy,
      isRead: true,
    ),
    Book(
      title: 'История России',
      author: 'Александр Орлов',
      year: 2010,
      genre: BookGenre.history,
    ),
  ];
}

Future<void> main() async {
  final books = await loadBooks();
  final repository = Repository<Book>()..addAll(books);

  print('Всего книг: ${repository.length}');

  // Анонимная функция в where.
  final unread = repository.where((book) => !book.isRead);
  print('\nНе прочитано (${unread.length}):');
  for (final book in unread) {
    print('  • ${book.title}');
  }

  // Поиск по названию: анонимная функция внутри обычного цикла while.
  const query = 'dart';
  var index = 0;
  Book? found;
  while (index < books.length) {
    final book = books[index];
    if (book.title.toLowerCase().contains(query)) {
      found = book;
      break;
    }
    index++;
  }
  print('\nПоиск «$query»: ${found?.describe() ?? 'ничего не найдено'}');

  // Сортировка через анонимную функцию-компаратор.
  final sorted = [...books]..sort((a, b) => a.year.compareTo(b.year));
  print('\nКниги по году издания:');
  for (final book in sorted) {
    print('  ${book.year} — ${book.title}');
  }

  // Метод класса меняет состояние объекта.
  if (found != null) {
    found.markAsRead();
    print('\nОтмечено как прочитано: ${found.describe()}');
  }

  print('\nСредний год издания: ${books.averageYear.toStringAsFixed(1)}');

  print('\nКниги по жанрам:');
  for (final entry in books.groupByGenre().entries) {
    final titles = entry.value.map((book) => book.title).join(', ');
    print('  ${entry.key.title}: $titles');
  }

  // Тот же generic-класс с другим типом.
  final numbers = Repository<int>()..addAll(<int>[3, 1, 2, 4]);
  final evens = numbers.where((value) => value.isEven);
  final firstOdd = numbers.firstWhereOrNull((value) => value.isOdd);
  print(
    '\nЧисла: ${numbers.items}, чётные: $evens, первое нечётное: $firstOdd',
  );
}
