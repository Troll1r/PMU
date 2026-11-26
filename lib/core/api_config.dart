import 'package:flutter/foundation.dart';

/// Настройки подключения к бэкенду из лабораторных по интернет-программированию.
abstract final class ApiConfig {
  /// Демонстрационный пользователь из seed-данных бэкенда.
  static const String demoLogin = 'user';
  static const String demoPassword = 'user123';

  /// Android-эмулятор обращается к localhost компьютера через 10.0.2.2.
  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3001';
    }
    return 'http://localhost:3001';
  }
}
