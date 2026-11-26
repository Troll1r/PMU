# ПМУ — лабораторные работы

Учебный Flutter-проект по дисциплине ПМУ.

- **Студент:** Кирюшин А.П.
- **Группа:** ПИбд-32

## Лабораторные работы

| № | Ветка | Что сделано |
|---|-------|-------------|
| 1 | `lab1` | Flutter-проект собран и запущен на Android; ФИО и группа выведены в AppBar |
| 2 | `lab2` | Dart: классы, enum, циклы, generics, анонимные функции, `Future` и `extension` |
| 3 | `lab3` | Список карточек книг: обложка, текст, рейтинг и жанр |
| 5 | `lab5` | Клиент-сервер: поиск курсов из API, DTO, интерфейс и репозиторий |

> Лабораторная 4 пока не выполнялась: ветка `lab5` создана от `lab3`.

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

## Лабораторная 5

Приложение получает курсы из бэкенда по интернет-программированию
(папка `ИП`, в git не входит).

### 1. Запустить бэкенд

```powershell
cd ИП\backend
.\gradlew.bat bootRun
```

Нужен JDK 17+. API слушает `http://localhost:3001`.

### 2. Запустить приложение

```powershell
flutter run
```

На Android-эмуляторе хост доступен по адресу `10.0.2.2`, поэтому
в приложении используется `http://10.0.2.2:3001`.

Поиск идёт через `GET /api/courses?search=<название>`, авторизация —
под демо-пользователем `user / user123` (JWT получается автоматически).

Код лабораторной:

- DTO: `lib/models/course_dto.dart`
- интерфейс: `lib/data/course_repository.dart`
- HTTP-репозиторий: `lib/data/http_course_repository.dart`
- экран поиска: `lib/screens/courses_screen.dart`
