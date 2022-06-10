import 'dart:convert';

// import 'package:absen_lite/models/shop_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';

class OutletService {
  // var data = [];
  // List<ShopModel> shops = [];
  String baseUrl = 'http://decoy.sakataguna-dev.com/api';

  Future<List<OutletModel>> getOutlets({String? token}) async {
    var url = Uri.parse('$baseUrl/user/show-shop');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data']['shop'];
      List<OutletModel> shops = [];

      // data.map((json) => ShopModel.fromJson(json)).where((shop) {
      //   final latShop = shop.lat;
      //   final longShop = shop.long;
      //   double radius =
      //       Geolocator.distanceBetween(latUser!, longUser!, latShop, longShop);
      //   // if radius
      //   bool check = true;
      //   // final searchLower = query!.toLowerCase();
      //   return check;
      //   // return titleLower.contains(searchLower);
      // }).toList();
      // toList();
      // if (query != null) {
      //   shops = shops
      //       .where(
      //           (shop) => shop.name.toLowerCase().contains(query.toLowerCase()))
      //       .toList();
      // }
      // AttendanceModel attendance = AttendanceModel.fromJson(data['attendance']);
      // attendance.token = 'Bearer' + data['access_token'];
      // print(data);

      for (var item in data) {
        shops.add(OutletModel.fromJson(item));
      }

      return shops;
    } else {
      throw Exception('Gagal Get shop');
    }
  }

  Future<List<Map<String, dynamic>>> getOutletsDistance(
      {String? token, double? latUser, double? longUser}) async {
    var url = Uri.parse('$baseUrl/user/show-shop');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data']['shop'];
      List<OutletModel> shops = [];
      // List<ShopDistanceModel> shopDistance = [];
      List<Map<String, dynamic>> locationListWithDistance = [];

      // data.map((json) => ShopModel.fromJson(json)).where((shop) {
      //   final latShop = shop.lat;
      //   final longShop = shop.long;
      //   double radius =
      //       Geolocator.distanceBetween(latUser!, longUser!, latShop, longShop);
      //   // if radius
      //   bool check = true;
      //   // final searchLower = query!.toLowerCase();
      //   return check;
      //   // return titleLower.contains(searchLower);
      // }).toList();
      // toList();
      // if (query != null) {
      //   shops = shops
      //       .where(
      //           (shop) => shop.name.toLowerCase().contains(query.toLowerCase()))
      //       .toList();
      // }
      // AttendanceModel attendance = AttendanceModel.fromJson(data['attendance']);
      // attendance.token = 'Bearer' + data['access_token'];
      // print(data);

      for (var item in data) {
        shops.add(OutletModel.fromJson(item));
      }

      for (var item in shops) {
        final latShop = item.lat;
        // print(latShop);
        final longShop = item.long;
        // print(longShop);

        // List test = item./;
        double radius =
            Geolocator.distanceBetween(latUser!, longUser!, latShop, longShop);
        locationListWithDistance.add({'shop': item, 'distance': radius});
      }

      // print(locationListWithDistance);
      locationListWithDistance.sort((a, b) {
        double d1 = a['distance'];
        double d2 = b['distance'];
        if (d1 > d2) {
          return 1;
        } else if (d1 < d2) {
          return -1;
        } else {
          return 0;
        }
      });

      // locationListWithDistance(shopDistance);
      // List<ShopDistanceModel> shopDistance = locationListWithDistance.toList();

      return locationListWithDistance;
    } else {
      throw Exception('Gagal Get shop');
    }
  }
}
