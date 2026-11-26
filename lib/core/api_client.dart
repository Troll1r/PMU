import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';

/// Ошибка обмена с API, которую можно показать пользователю.
class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// HTTP-клиент: логинится под демо-пользователем и добавляет Bearer-токен.
class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  String? _accessToken;

  Future<Map<String, dynamic>> getJson(Uri uri) async {
    await _ensureAuthorized();

    var response = await _get(uri);
    if (response.statusCode == 401) {
      _accessToken = null;
      await _ensureAuthorized();
      response = await _get(uri);
    }

    if (response.statusCode != 200) {
      throw ApiException('Сервер вернул ошибку ${response.statusCode}.');
    }
    return _decodeObject(response);
  }

  Future<http.Response> _get(Uri uri) {
    return _client
        .get(
          uri,
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer $_accessToken',
          },
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<void> _ensureAuthorized() async {
    if (_accessToken != null) {
      return;
    }

    final response = await _client
        .post(
          Uri.parse('${ApiConfig.baseUrl}/api/auth/login'),
          headers: const <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'login': ApiConfig.demoLogin,
            'password': ApiConfig.demoPassword,
          }),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw ApiException(
        'Не удалось авторизоваться в API (${response.statusCode}). '
        'Проверь, что бэкенд запущен на порту 3001.',
      );
    }

    final body = _decodeObject(response);
    final token = body['accessToken'];
    if (token is! String || token.isEmpty) {
      throw const ApiException('Сервер не вернул accessToken.');
    }
    _accessToken = token;
  }

  Map<String, dynamic> _decodeObject(http.Response response) {
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw const ApiException('Сервер вернул неожиданный формат данных.');
    }
    return decoded;
  }

  void close() {
    _client.close();
  }
}
