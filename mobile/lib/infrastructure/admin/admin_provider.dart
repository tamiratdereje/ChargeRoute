

import 'dart:convert';

import 'package:charge_station_finder/infrastructure/admin/admin_dto.dart';
import 'package:http/http.dart' as http;


class AdminProvider {
  final String baseUrl = "";
  final String token = "";

  
  Future<void> createUser(AdminModel adminModel) async {

    final response = await http.post(Uri.parse(baseUrl),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
    body: jsonEncode(adminModel)
    );

    if (response.statusCode == 201) {
      print(response.body);
    }

  }

  Future<void> editUser(AdminModel adminModel) async {

    String id = adminModel.id!;

    final response = await http.put(Uri.parse("$baseUrl/$id"),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
    body: jsonEncode(adminModel)
    );

    if (response.statusCode != 200){
        throw Exception('failed to edit');
      }

  }

  Future<void> deleteUser(String id) async {

      final response = await http.delete(Uri.parse("$baseUrl/$id"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
      );     

      if (response.statusCode != 200){
        print(response.body);
        throw Exception('failed to delete');
      } 
    }

  Future<void> deleteRole(String id) async {

      final response = await http.delete(Uri.parse("$baseUrl/role/$id"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
      );     

      if (response.statusCode != 200){
        print(response.body);
        throw Exception('failed to delete');
      } 
  }

  Future<void> createRole(String role) async {

    final response = await http.post(Uri.parse("$baseUrl/role"),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
    body: jsonEncode(role)
    );

    if (response.statusCode == 201) {
      print(response.body);
    }

  }


    Future<List<AdminModel>> getUsers() async {


        String token = "";
        final response = await http
            .get(Uri.parse(baseUrl),
             headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
             );

        if (response.statusCode == 200) {

          final json =jsonDecode(response.body);
           List<dynamic> users = json["data"] ?? [];

          List<AdminModel> related1 = users.map((user) => AdminModel.fromJson(user)).toList();
          
          
          return related1;

          } else {
          throw Exception("error fetching users");
        }
    }
 
}