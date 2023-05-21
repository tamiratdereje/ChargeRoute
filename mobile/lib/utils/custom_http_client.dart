import 'package:charge_station_finder/utils/extensions.dart';
import 'package:http/http.dart' as http;

import '../common/constants.dart';

class CustomHttpClient {
  static String baseUrl = Constants.baseUrl;

  final http.Client _httpClient = http.Client();
  String? _authToken;

  CustomHttpClient();

  set authToken(String? value) {
    _authToken = value;
  }

  Future<http.Response> get(String url,
      {Map<String, String> headers = const {}}) async {
    Map<String, String> headersWithContentTypeAndAuth = {
      ...headers,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return _httpClient.get(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
    );
  }

  Future<http.Response> post(String url,
      {Map<String, String> headers = const <String, String>{},
      Object? body,
      String contentType = "application/json"}) async {
    Map<String, String> headersWithContentTypeAndAuth = {
      ...headers,
      'Content-Type': contentType,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return _httpClient.post(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
      body: body,
    );
  }

  Future<http.Response> put(String url,
      {Map<String, String> headers = const {},
      Object? body,
      String contentType = "application/json"}) async {
    Map<String, String> headersWithContentTypeAndAuth = {
      ...headers,
      'Content-Type': contentType,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return _httpClient.put(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
      body: body,
    );
  }

  Future<http.Response> patch(String url,
      {Map<String, String> headers = const {},
      Object? body,
      String contentType = "application/json"}) async {
    Map<String, String> headersWithContentTypeAndAuth = {
      ...headers,
      'Content-Type': contentType,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return _httpClient.patch(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
      body: body,
    );
  }

  Future<http.Response> delete(String url,
      {Map<String, String> headers = const {},
      Object? body,
      String contentType = "application/json"}) async {
    Map<String, String> headersWithContentTypeAndAuth = {
      ...headers,
      'Content-Type': contentType,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return _httpClient.delete(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
      body: body,
    );
  }
}
