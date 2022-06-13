import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nsai_id/models/region_model.dart';

class RegionService {
  String baseUrl = 'http://nsa-backend.sakataguna-dev.com';

  Future<List<RegionModel>> getRegion() async {
    var url = Uri.parse('$baseUrl/region');

    var response = await http.post(url);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['region'];
      print(data);
      List<RegionModel> regions = [];
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // var token = prefs.setString('token', user.token as String);
      for (var region in data) {
        regions.add(RegionModel.fromJson(region));
      }

      return regions;
    } else {
      throw Exception('Gagal get region');
    }
  }
}
