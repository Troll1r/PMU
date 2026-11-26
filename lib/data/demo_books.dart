import '../models/book.dart';

/// Демонстрационная подборка книг для лабораторной работы №3.
const List<Book> demoBooks = <Book>[
  Book(
    title: 'Dart в действии',
    author: 'Эрик Фриман',
    year: 2022,
    genre: 'Программирование',
    rating: 4.8,
    coverAsset: 'assets/images/dart_in_action.png',
    description: 'Практическое руководство по современному Dart: коллекции, асинхронность и тесты.',
  ),
  Book(
    title: 'Чистый код',
    author: 'Роберт Мартин',
    year: 2008,
    genre: 'Программирование',
    rating: 4.9,
    coverAsset: 'assets/images/clean_code.png',
    description:
        'Принципы написания понятного, поддерживаемого и надёжного кода.',
  ),
  Book(
    title: 'Краткая история времени',
    author: 'Стивен Хокинг',
    year: 1988,
    genre: 'Наука',
    rating: 4.6,
    coverAsset: 'assets/images/brief_history_of_time.png',
    description:
        'От Большого взрыва до чёрных дыр — сложные идеи простым языком.',
  ),
  Book(
    title: 'Властелин колец',
    author: 'Дж. Р. Р. Толкин',
    year: 1954,
    genre: 'Фэнтези',
    rating: 5.0,
    coverAsset: 'assets/images/lotr.png',
    description:
        'Эпическая история о хоббитах, Кольце Всевластия и Средиземье.',
  ),
  Book(
    title: 'История России',
    author: 'А. С. Орлов',
    year: 2010,
    genre: 'История',
    rating: 4.2,
    coverAsset: 'assets/images/russian_history.png',
    description: 'Основные события, эпохи и личности отечественной истории.',
  ),
];
