import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:nsai_id/models/history_attendance_model.dart';
import 'package:path/path.dart';
import 'package:nsai_id/models/attendance_model.dart';

class AttendanceService {
  String baseUrl = 'http://nsa-api.sakataguna-dev.com/api';

  Future<List<AttendanceHistoryModel>> getAttendancesHistory(
      {String? token, String? id}) async {
    // var token = await.getToken();
    var url = Uri.parse('$baseUrl/attendance/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<AttendanceHistoryModel> attendances = [];

      for (var item in data) {
        attendances.add(AttendanceHistoryModel.fromJson(item));
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

  Future<AttendanceModel> attendanceOut({
    String? id,
    String? token,
    String? time,
  }) async {
    var url = Uri.parse('$baseUrl/attendance/clock-out/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var body = jsonEncode({'clock_out': time});

    var response = await http.put(url, headers: headers, body: body);

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

      // print('ini' + listItemTaken.toString());

      var formData = dio.FormData.fromMap({'item': listItemTaken});
      var file_item = await dio.MultipartFile.fromFile(image!.path,
          filename: basename(image.path),
          contentType: MediaType("image", basename(image.path)));
      var file_distributor = await dio.MultipartFile.fromFile(image2!.path,
          filename: basename(image2.path),
          contentType: MediaType("image", basename(image2.path)));
      formData.files.add(MapEntry('item_photo', file_item));
      formData.files.add(MapEntry('distributor_photo', file_distributor));
      // for (var data in listItemTaken) {
      //   formData.fields.add(MapEntry('product_id', data['product_id']));
      //   formData.fields.add(MapEntry('item_taken', data['item_taken']));
      // }

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

  Future<List<AttendanceHistoryModel>> getItemTaken(
      {String? token, String? id}) async {
    // var token = await.getToken();
    var url = Uri.parse('$baseUrl/visiting/item/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print('Item Taken' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<AttendanceHistoryModel> attendances = [];

      for (var item in data) {
        attendances.add(AttendanceHistoryModel.fromJson(item));
      }

      return attendances;
    } else {
      throw Exception('Gagal Get attendances');
    }
  }
}
