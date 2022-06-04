import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nsai_id/models/user_model.dart';

class AuthService {
  String baseUrl = 'http://decoy.sakataguna-dev.com/api';

  Future<UserModel> login({
    String? username,
    String? password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'username': username, 'password': password});

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // var token = prefs.setString('token', user.token as String);
      user.access_token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Login');
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
  ) async {
    var url = Uri.parse('$baseUrl/user');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.access_token = 'Bearer ' + token;
      // print(user.access_token);

      return user;
    } else {
      throw Exception('Gagal getuser');
    }
  }
}
