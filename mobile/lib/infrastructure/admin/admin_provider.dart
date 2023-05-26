

import 'dart:convert';

import 'package:charge_station_finder/infrastructure/admin/admin_dto.dart';
import 'package:http/http.dart' as http;


class AdminProvider {
  final String baseUrl = "http://localhost:4500/api/v1/user";
  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NjRiMTIzMjY4OTJjZTQ0OGE0YWUyYSIsImlhdCI6MTY4NDk4NDc2NCwiZXhwIjoxNjg3NTc2NzY0fQ.YCguBsZeIf7fACYrz3qcsShFjF7JYZnv60QYrkvyHfY";
  http.Client client = http.Client();

  Future<void> createUser(AdminModel adminModel) async {
    print(adminModel.toJson());
    
    final response = await client.post(Uri.parse(baseUrl),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
    body: jsonEncode(adminModel)
    );

    print(response.statusCode);

    if (response.statusCode != 200) {
      throw Exception('failed to create');

    }

  }

  Future<AdminModel> editUser(AdminModel adminModel) async {

    String id = adminModel.id!;
    final response = await client.put(Uri.parse("$baseUrl/update/$id"),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
    body: jsonEncode(adminModel)
    );

    if (response.statusCode != 200){
        throw Exception('failed to edit');
      }
    return adminModel;

  }

  Future<void> deleteUser(String id) async {

      final response = await client.delete(Uri.parse("$baseUrl/$id"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
      );     

      if (response.statusCode != 200){
        throw Exception('failed to delete');
      } 
    }

 

    Future<List<AdminModel>> getUsers() async {

      try {
        
        final response = await client
            .get(Uri.parse("$baseUrl/all"),
             headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  "token": token},
             );
        
      final json =jsonDecode(response.body);
      List<dynamic> users = json["data"] ?? [];
      List<AdminModel> related1 = users.map((user) => AdminModel.fromJson(user)).toList();          
      return related1;

      } catch (e) {

        print(e);
        throw Exception("error fetching users");

      }        
    }


    Future<AdminModel> getUser(String id) async {

        final response = await client
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