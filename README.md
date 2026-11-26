# ПМУ — лабораторные работы

Учебный Flutter-проект по дисциплине ПМУ.

- **Студент:** Кирюшин А.П.
- **Группа:** ПИбд-32

## Лабораторные работы

| № | Ветка | Что сделано |
|---|-------|-------------|
| 1 | `lab1` | Flutter-проект собран и запущен на Android; ФИО и группа выведены в AppBar |
| 2 | `lab2` | Dart: классы, enum, циклы, generics, анонимные функции, `Future` и `extension` |

## Запуск

```bash
flutter pub get
flutter run
```

Для запуска на Android нужен эмулятор или подключённое устройство:

```bash
flutter emulators --launch Medium_Phone_API_37.0
flutter run -d emulator-5554
```

## Лабораторная 2

Демонстрация возможностей Dart находится в `lib/lab2/dart_basics.dart`:

```bash
dart run lib/lab2/dart_basics.dart
```
