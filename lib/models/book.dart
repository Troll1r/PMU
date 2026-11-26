/// Книга для отображения в списке карточек.
class Book {
  const Book({
    required this.title,
    required this.author,
    required this.year,
    required this.genre,
    required this.rating,
    required this.coverAsset,
    required this.description,
  });

  final String title;
  final String author;
  final int year;
  final String genre;
  final double rating;
  final String coverAsset;
  final String description;
}
