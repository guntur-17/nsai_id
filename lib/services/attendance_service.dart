import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nsai_id/models/attendance_model.dart';

class AttendanceService {
  String baseUrl = 'http://nsa-api.sakataguna-dev.com/api';
  // String token = AuthProvider.user.token;

  Future<List<AttendanceModel>> getAttendances(String? token) async {
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
      List<AttendanceModel> attendances = [];

      for (var item in data) {
        attendances.add(AttendanceModel.fromJson(item));
      }

      return attendances;
    } else {
      throw Exception('Gagal Get attendances');
    }
  }

  Future<AttendanceModel> attendanceIn({
    String? token,
    String? distributor_id,
    String? clock_in,
    String? address,
  }) async {
    var url = Uri.parse('$baseUrl/attendance/clock-in');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var body = jsonEncode({
      'distributor_id': distributor_id,
      'clock_in': clock_in,
      'address': address
    });

    var response = await http.post(url, headers: headers, body: body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var dataa = jsonDecode(response.body)['data'];
      AttendanceModel data = AttendanceModel.fromJson(dataa);
      return data;
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
