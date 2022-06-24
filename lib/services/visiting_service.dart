import 'dart:convert';

import 'package:http/http.dart' as http;
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
}
