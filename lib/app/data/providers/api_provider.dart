import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const String baseUrl = 'https://api.example.com';
  static const Duration timeout = Duration(seconds: 30);

  // Headers
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> _authHeaders(String token) => {
    ..._headers,
    'Authorization': 'Bearer $token',
  };

  // GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    String? token,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseUrl$endpoint',
      ).replace(queryParameters: queryParams);

      final response = await http
          .get(
            uri,
            headers: token != null ? _authHeaders(token) : _headers,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  // POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .post(
            uri,
            headers: token != null ? _authHeaders(token) : _headers,
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  // PUT request
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .put(
            uri,
            headers: token != null ? _authHeaders(token) : _headers,
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('PUT request failed: $e');
    }
  }

  // DELETE request
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .delete(
            uri,
            headers: token != null ? _authHeaders(token) : _headers,
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  // Handle response
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }
  }
}
