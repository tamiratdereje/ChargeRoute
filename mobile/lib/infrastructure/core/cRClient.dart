// Auth interceptor for http requests

import 'package:charge_station_finder/infrastructure/core/constants.dart';
import 'package:http/http.dart' as http;

import '../data-source/local/sharedPrefHelper.dart';

class CRClient {
  final http.Client client = http.Client();

  Future<Map<String, String>> getHeader() async {
    var token = await ShardPrefHelper.getString(Constants.TOKEN_KEY);
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    return headers;
  }

  Future<http.Response> get(String url) async {
    var headers = await getHeader();
    final response = await client.get(Uri.parse(url), headers: headers);
    return response;
  }

  Future<http.Response> post(String url, Map<String, dynamic>? body) async {
    var headers = await getHeader();
    final response =
        await client.post(Uri.parse(url), headers: headers, body: body);
    return response;
  }

  Future<http.Response> put(String url, Map<String, dynamic>? body) async {
    var headers = await getHeader();
    final response =
        await client.put(Uri.parse(url), headers: headers, body: body);
    return response;
  }

  Future<http.Response> delete(String url) async {
    var headers = await getHeader();
    final response = await client.delete(Uri.parse(url), headers: headers);
    return response;
  }
}
