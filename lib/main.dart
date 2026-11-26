import 'package:flutter/material.dart';

import 'screens/books_screen.dart';

void main() {
  runApp(const PmuApp());
}

class PmuApp extends StatelessWidget {
  const PmuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ПМУ — лабораторные работы',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const BooksScreen(),
    );
  }
}
