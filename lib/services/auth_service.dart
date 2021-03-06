import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nsai_id/models/user_model.dart';

import '../theme.dart';

class AuthService {
  String baseUrl = 'http://nsa-api.sakataguna-dev.com/api';

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      UserModel user = UserModel.fromJson(data['data']);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // var token = prefs.setString('token', user.token as String);
      print(user.id);
      user.access_token = 'Bearer ' + data['access_token'];
      print(user.access_token);
      // parseJwt(user.access_token!);
      // print(parseJwt(user.access_token!));
      // print(_decodeJwt(user.access_token!));
      // user.id = _decodeJwt(user.access_token!);
      // print(user.id);

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<bool> register({
    BuildContext? context,
    String? full_name,
    String? nick_name,
    String? id_card_number,
    String? region_id,
    String? email,
    String? password,
  }) async {
    var url = Uri.parse('$baseUrl/register');
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'full_name': full_name,
      'nick_name': nick_name,
      'id_card_number': id_card_number,
      'region_id': region_id,
      'email': email,
      'password': password,
    });

    var response = await http.post(url, headers: headers, body: body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['meta']['message'];
      var validation = jsonDecode(response.body)['data']['validation_errors'];
      print(message);
      print(validation);
      if (message == 'Validation Error') {
        switch (validation.toString()) {
          case '{id_card_number: [The id card number has already been taken.]}':
            return throw ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(
                backgroundColor: redColor,
                content: Text(
                  'NIK sudah terdaftar',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          case '{email: [The email has already been taken.]}':
            return throw ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(
                backgroundColor: redColor,
                content: Text(
                  'Email sudah terdaftar',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          default:
            return throw ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(
                backgroundColor: redColor,
                content: Text(
                  'Terjadi kesalahan',
                  textAlign: TextAlign.center,
                ),
              ),
            );
        }
      }
      return true;
    } else {
      throw Exception('Gagal attendance in ');
    }
  }

  Future<bool> logout(String? token) async {
    var url = Uri.parse('$baseUrl/logout');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.post(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal disini');
    }
  }

  Future<UserModel> getUser(
    String? token,
    String? id,
  ) async {
    var url = Uri.parse('$baseUrl/user/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      // print('data here');
      // print(data);
      UserModel user = UserModel.fromJson(data);
      // print('user here');
      // print(user);
      user.access_token = token;
      // print(user.access_token);
      // print('border');

      return user;
    } else {
      throw Exception('Gagal getuser');
    }
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  _decodeJwt(String token) {
    Map<String, dynamic> tokenDecoded = parseJwt(token);
    String id = tokenDecoded['uid'];

    return id;
  }
}
