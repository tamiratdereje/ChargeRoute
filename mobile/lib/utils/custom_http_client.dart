import 'dart:convert';

import 'package:charge_station_finder/common/exceptions/ApiException.dart';
import 'package:charge_station_finder/utils/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../common/constants.dart';
import '../common/exceptions/ServerException.dart';

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

    return runInterceptors(_httpClient.get(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
    ));
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
    debugPrint(baseUrl + url);
    return runInterceptors(_httpClient.post(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
      body: body,
    ));
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

    return runInterceptors(_httpClient.put(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
      body: body,
    ));
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

    return runInterceptors(_httpClient.patch(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
      body: body,
    ));
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
    
    return runInterceptors(_httpClient.delete(
      (baseUrl + url).asUri,
      headers: headersWithContentTypeAndAuth,
      body: body,
    ));
  }

  Future<http.Response> runInterceptors(Future<http.Response> response) async {
    return interceptForError(await interceptForLogging(await response));
  }

  Future<http.Response> interceptForError(http.Response response) async {
    if (response.statusCode < 300) {
      return response;
    }
    var decoded = json.decode(response.body);
    var message = decoded['error'] as String?;

    if (response.statusCode >= 400 && response.statusCode < 500) {
      debugPrint('Error: ${response.statusCode} - ${response.body}');
      throw ApiException(message ?? 'Bad request', response.statusCode);
    } else if (response.statusCode >= 500) {
      throw ServerException(message ?? 'Server error', response.statusCode);
    }
    return response;
  }

  Future<http.Response> interceptForLogging(http.Response response) async {
    var request = response.request;
    debugPrint('>> ${request?.url}');
    debugPrint('Headers\n ${request?.headers}');

    if (request is http.Request) {
      debugPrint('Body\n ${request.body}');
    }

    debugPrint('Res Code\n ${response.statusCode}');
    debugPrint('Res Body\n ${response.body}');
    return response;
  }
}
