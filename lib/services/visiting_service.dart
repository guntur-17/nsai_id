import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:nsai_id/models/visiting_history_model.dart';
import 'package:path/path.dart';
import 'package:nsai_id/models/visiting_model.dart';

class VisitingService {
  String baseUrl = 'http://nsa-api.sakataguna-dev.com/api';
  // String token = AuthProvider.user.token;

  Future<List<VisitingModel>> getVisiting(String? token, String? id) async {
    // var token = await.getToken();
    var url = Uri.parse('$baseUrl/visiting/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<VisitingModel> visiting = [];

      for (var item in data) {
        visiting.add(VisitingModel.fromJson(item));
      }

      return visiting;
    } else {
      throw Exception('Gagal Get visiting');
    }
  }

  Future<List<VisitingHistoryModel>> getVisitingHistory(
      {String? token, String? id}) async {
    // var token = await.getToken();
    var url = Uri.parse('$baseUrl/visiting/$id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<VisitingHistoryModel> visiting = [];

      for (var item in data) {
        visiting.add(VisitingHistoryModel.fromJson(item));
      }

      return visiting;
    } else {
      throw Exception('Gagal Get attendances');
    }
  }

  Future<VisitingModel> visitingIn({
    String? token,
    String? outlet_id,
    String? clock_in,
    String? address,
  }) async {
    var url = Uri.parse('$baseUrl/visiting/clock-in');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };
    var body = jsonEncode(
        {'outlet_id': outlet_id, 'clock_in': clock_in, 'address': address});

    var response = await http.post(url, headers: headers, body: body);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var dataa = jsonDecode(response.body)['data'];
      VisitingModel data = VisitingModel.fromJson(dataa);
      return data;
    } else {
      throw Exception('Gagal visiting in ');
    }
  }

  Future<bool> visitingOut(
    String? token,
    String? time,
    String? id,
    double? lat,
    double? long,
  ) async {
    var url = Uri.parse('$baseUrl/visiting/clock-out/$id');
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
      throw Exception('Gagal visiting out ');
    }
  }

  Future<bool> visitingPhoto(
      String? id,
      String? token,
      File? image,
      File? image2,
      File? image3,
      List<Map<String, dynamic>> listItemTaken) async {
    try {
      // print(image);
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = '$baseUrl/visiting/post-photo/$id';
      dioRequest.options.headers = {
        'Authorization': '$token',
        'Content-Type': 'multipart/form-data'
      };

      // print('ini' + listItemTaken.toString());

      var formData = dio.FormData.fromMap({'item': listItemTaken});
      var file_item = await dio.MultipartFile.fromFile(image!.path,
          filename: basename(image.path),
          contentType: MediaType("image", basename(image.path)));
      var file_outlet = await dio.MultipartFile.fromFile(image2!.path,
          filename: basename(image2.path),
          contentType: MediaType("image", basename(image2.path)));
      var file_other = await dio.MultipartFile.fromFile(image3!.path,
          filename: basename(image3.path),
          contentType: MediaType("image", basename(image3.path)));
      formData.files.add(MapEntry('item_photo', file_item));
      formData.files.add(MapEntry('other_photo', file_other));
      formData.files.add(MapEntry('outlet_photo', file_outlet));
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
}
