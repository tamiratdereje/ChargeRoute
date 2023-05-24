import 'dart:convert';

import 'package:charge_station_finder/infrastructure/core/cRClient.dart';
import 'package:charge_station_finder/infrastructure/dto/userAuthCredential.dart';
import 'package:charge_station_finder/infrastructure/dto/SignInDto.dart';
import 'package:charge_station_finder/infrastructure/dto/SignUpDto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../domain/auth/models/noReturn.dart';
import '../../dto/changePasswordDto.dart';

class AuthenticationService {
  final CRClient client = CRClient();
  final String _baseUrl = 'https://charge-route.onrender.com/';

  Future<NoReturns> signUp(SignUpDto signUpDto) async {
    try {
      final response = await client.post(
        '$_baseUrl/api/v1/auth/signup'
          ,signUpDto.toJson());
      if (response.statusCode == 200) {
        return const NoReturns();
      } else {
        throw Exception('sign up failed ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('unable to create user ${e.toString()}');
    }
  }

  Future<UserAuthCredential> signIn(SignInDto signInDto) async {
    try {
      final response = await client.post(
          '$_baseUrl/api/v1/user/login',
          signInDto.toJson());

      if (response.statusCode == 200) {
        return UserAuthCredential.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to sign in ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(signInDto.toJson().toString());
      throw Exception('Failed to sign in ${e.toString()}');
    }
  }

  Future<NoReturns> signOut() async {
    final response = await client.post(
      '$_baseUrl/api/v1/user',null);
    if (response.statusCode == 200) {
      return const NoReturns();
    } else {
      throw Exception('Failed to signout');
    }
  }

  Future<NoReturns> deleteAccount() async {
    final response = await client.delete(
      '$_baseUrl/api/v1/user');
    if (response.statusCode == 200) {
      return const NoReturns();
    } else {
      throw Exception('Failed to delete account.');
    }
  }

  Future<NoReturns> ChangePassword(ChangePasswordDto changePasswordDto) async {
    final response = await client.post(
      '$_baseUrl/api/v1/user/changepassword',null);
    if (response.statusCode == 200) {
      return const NoReturns();
    } else {
      throw Exception('Failed to create user.');
    }
  }
}
