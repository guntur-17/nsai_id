import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
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

  Future<bool> absentPhoto(String? id, String? token, File? image, File? image2,
      List<Map<String, dynamic>> listItemTaken) async {
    try {
      // print(image);
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = '$baseUrl/attendance/post-photo/$id';
      dioRequest.options.headers = {
        'Authorization': '$token',
        'Content-Type': 'multipart/form-data'
      };

      var formData =
          dio.FormData.fromMap({"item": jsonEncode(listItemTaken.join(","))});
      var file_item = await dio.MultipartFile.fromFile(image!.path,
          filename: basename(image.path),
          contentType: MediaType("image", basename(image.path)));
      var file_distributor = await dio.MultipartFile.fromFile(image2!.path,
          filename: basename(image2.path),
          contentType: MediaType("image", basename(image2.path)));
      formData.files.add(MapEntry('item_photo', file_item));
      formData.files.add(MapEntry('distributor_photo', file_distributor));
      print(formData);

      var response = await dioRequest.post(
        dioRequest.options.baseUrl,
        data: formData,
      );
      final result = json.decode(response.toString())['data'];
      return true;
    } catch (err) {
      print('ERROR  $err');
      return false;
    }
  }
}
