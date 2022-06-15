import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nsai_id/models/region_model.dart';

class RegionService {
  String baseUrl = 'http://nsa-api.sakataguna-dev.com/api';

  Future<List<RegionModel>> getRegion() async {
    // var token = await.getToken();
    var url = Uri.parse('$baseUrl/region');

    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['region'];
      List<RegionModel> regions = [];

      for (var item in data) {
        regions.add(RegionModel.fromJson(item));
      }
      print(data);

      return regions;
    } else {
      throw Exception('Gagal Get attendances');
    }
  }
}
