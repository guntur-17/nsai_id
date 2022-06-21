import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nsai_id/models/distributor_model.dart';

class DistributorService {
  String baseUrl = 'http://nsa-api.sakataguna-dev.com/api';
  // String token = AuthProvider.user.token;

  Future<List<DistributorModel>> getDistributors2(String? token) async {
    // var token = await.getToken();
    var url = Uri.parse('$baseUrl/user/attendance/history');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['attendance'];
      List<DistributorModel> distributors = [];

      for (var item in data) {
        distributors.add(DistributorModel.fromJson(item));
      }

      return distributors;
    } else {
      throw Exception('Gagal Get distributor');
    }
  }

  Future<List<DistributorModel>> getDistributors({String? token}) async {
    var url = Uri.parse('$baseUrl/distributor');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data);
      List<DistributorModel> distributors = [];

      for (var item in data) {
        distributors.add(DistributorModel.fromJson(item));
      }

      return distributors;
    } else {
      throw Exception('Gagal Get outlet');
    }
  }

  Future<bool> attendanceIn(
    String? token,
    String? time,
    double? lat,
    double? long,
  ) async {
    var url = Uri.parse('$baseUrl/user/attendance-in');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var body = jsonEncode({'time': time, 'lat': lat, 'long': long});

    var response = await http.post(url, headers: headers, body: body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal attendance in ');
    }
  }

  Future<bool> attendanceOut(
    String? token,
    String? time,
    double? lat,
    double? long,
  ) async {
    var url = Uri.parse('$baseUrl/user/attendance-out');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var body = jsonEncode({'time': time, 'lat': lat, 'long': long});

    var response = await http.post(url, headers: headers, body: body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal attendance in ');
    }
  }
}
