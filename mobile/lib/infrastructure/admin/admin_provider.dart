

import 'dart:convert';

import 'package:charge_station_finder/infrastructure/admin/admin_dto.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../data-source/local/sharedPrefHelper.dart';


class AdminProvider {
  static String baseUrl = Constants.baseUrl;
  

  
  // final String baseUrl = "http://localhost:4500/api/v1/user";
  http.Client client = http.Client();

  Future<void> createUser(AdminModel adminModel) async {

    var userData = await ShardPrefHelper.getUser();
    var authToken = userData!.token;
    print(adminModel.toJson());
    
    final response = await client.post(Uri.parse(baseUrl + "user"),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  'Authorization': 'Bearer $authToken'},
    body: jsonEncode(adminModel)
    );

    print(response.statusCode);

    if (response.statusCode != 200) {
      throw Exception('failed to create');

    }

  }

  Future<AdminModel> editUser(AdminModel adminModel) async {
    var userData = await ShardPrefHelper.getUser();
    var authToken = userData!.token;

    String id = adminModel.id!;
    final response = await client.put(Uri.parse("$baseUrl/user/update/$id"),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
    body: jsonEncode(adminModel)
    );

    if (response.statusCode != 200){
        throw Exception('failed to edit');
      }
    return adminModel;

  }

  Future<void> deleteUser(String id) async {
      var userData = await ShardPrefHelper.getUser();
      var authToken = userData!.token;

      final response = await client.delete(Uri.parse(baseUrl + "user/$id"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
      );     

      if (response.statusCode != 200){
        throw Exception('failed to delete');
      } 
    }
 

    Future<List<AdminModel>> getUsers() async {

      try {
        var userData = await ShardPrefHelper.getUser();
        var authToken = userData!.token;
        
        final response = await client
            .get(Uri.parse(baseUrl + "user/all"),
             headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',  'Authorization': 'Bearer $authToken'},
             );
      print(response.body);
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
        var userData = await ShardPrefHelper.getUser();
        var authToken = userData!.token;

        final response = await client
            .get(Uri.parse(baseUrl + "user/$id"),
             headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
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