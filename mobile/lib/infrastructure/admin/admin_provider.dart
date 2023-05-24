

import 'dart:convert';

import 'package:charge_station_finder/infrastructure/admin/admin_dto.dart';
import 'package:http/http.dart' as http;


class AdminProvider {
  final String baseUrl = "https://charge-route.onrender.com/api/v1/user";
  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NjRiMTIzMjY4OTJjZTQ0OGE0YWUyYSIsImlhdCI6MTY4NDY5OTM0MiwiZXhwIjoxNjg3MjkxMzQyfQ.-HXeKUNxGtaatkQiYcOW7zg2VXN4sXd-g8sIZ9RTHwo";

  
  Future<void> createUser(AdminModel adminModel) async {
    print(adminModel.toJson());
    final response = await http.post(Uri.parse(baseUrl),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
    body: jsonEncode(adminModel)
    );

    print(response.statusCode);

    if (response.statusCode != 200) {
      throw Exception('failed to create');

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


    Future<AdminModel> getUser(String id) async {

        final response = await http
            .get(Uri.parse("$baseUrl/$id"),
             headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
             );

        if (response.statusCode == 200) {

          final json =jsonDecode(response.body);
          AdminModel user = AdminModel.fromJson(json["data"]);
          
          return user;

          } else {
          throw Exception("error fetching user");
        }
    }
 
}