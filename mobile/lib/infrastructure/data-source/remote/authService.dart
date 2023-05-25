import 'dart:convert';
import 'package:charge_station_finder/infrastructure/dto/userAuthCredential.dart';
import 'package:charge_station_finder/infrastructure/dto/SignInDto.dart';
import 'package:charge_station_finder/infrastructure/dto/SignUpDto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../domain/auth/models/noReturn.dart';
import '../../../utils/custom_http_client.dart';
import '../../dto/changePasswordDto.dart';

class AuthenticationService {
  final CustomHttpClient httpClient;

  AuthenticationService(this.httpClient);

  Future<NoReturns> signUp(SignUpDto signUpDto) async {
    await httpClient.post('user', body: jsonEncode(signUpDto.toJson()));
    return const NoReturns();
  }


  Future<UserData> signIn(SignInDto signInDto) async {
    final response =
        await httpClient.post('user/login', body: jsonEncode(signInDto.toJson()));
    return UserData.fromJson(jsonDecode(response.body));
  }

  Future<NoReturns> signOut() async {
    final response = await httpClient.post('/user/logout');
    return const NoReturns();
  }

  Future<NoReturns> deleteAccount() async {
    final response = await httpClient.delete('/user');
    return const NoReturns();
  }

  Future<NoReturns> ChangePassword(ChangePasswordDto changePasswordDto) async {
    final response = await httpClient.post('user/changepassword',
        body: jsonEncode(changePasswordDto.toJson()));
    return const NoReturns();
  }
}
