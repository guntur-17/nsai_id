// import 'package:nsai_id/models/product_model.dart';

// final allProduct = <Product>[
//   Product(
//     id: 1,
//     name: 'Susu',
//     unit: 'Kotak',
//     price: 12000,
//     taken: 1,
//   ),
//   Product(
//     id: 2,
//     name: 'Detergen',
//     unit: 'Karton',
//     price: 10000,
//     taken: 3,
//   ),
//   Product(
//     id: 3,
//     name: 'Beras',
//     unit: 'Kg',
//     price: 5000,
//     taken: 2,
//   ),
//   Product(
//     id: 4,
//     name: 'Garam',
//     unit: 'Gr',
//     price: 2000,
//     taken: 6,
//   ),
// ];

import 'dart:convert';

// import 'package:absen_lite/models/shop_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:nsai_id/models/product_model.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';

class ProductService {
  // var data = [];
  // List<ShopModel> shops = [];
  String baseUrl = 'http://nsa-api.sakataguna-dev.com/api';

  Future<List<ProductModel>> getProducts(
      {String? token, String? distributor_id}) async {
    var url = Uri.parse('$baseUrl/product/$distributor_id');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print("test");
      List data = json.decode(response.body)['data'];
      print(data);
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Get outlet');
    }
  }

  // Future<List<Map<String, dynamic>>> getOutletsDistance(
  //     {String? token, double? latUser, double? longUser}) async {
  //   var url = Uri.parse('$baseUrl/user/show-shop');
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': token as String
  //   };

  //   var response = await http.get(url, headers: headers);

  //   print(response.statusCode);
  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     List data = json.decode(response.body)['data']['shop'];
  //     List<OutletModel> shops = [];
  //     // List<ShopDistanceModel> shopDistance = [];
  //     List<Map<String, dynamic>> locationListWithDistance = [];

  //     for (var item in data) {
  //       shops.add(OutletModel.fromJson(item));
  //     }

  //     for (var item in shops) {
  //       final latShop = item.lat;
  //       // print(latShop);
  //       final longShop = item.long;
  //       // print(longShop);

  //       // List test = item./;
  //       double radius =
  //           Geolocator.distanceBetween(latUser!, longUser!, latShop, longShop);
  //       locationListWithDistance.add({'shop': item, 'distance': radius});
  //     }

  //     // print(locationListWithDistance);
  //     locationListWithDistance.sort((a, b) {
  //       double d1 = a['distance'];
  //       double d2 = b['distance'];
  //       if (d1 > d2) {
  //         return 1;
  //       } else if (d1 < d2) {
  //         return -1;
  //       } else {
  //         return 0;
  //       }
  //     });

  //     // locationListWithDistance(shopDistance);
  //     // List<ShopDistanceModel> shopDistance = locationListWithDistance.toList();

  //     return locationListWithDistance;
  //   } else {
  //     throw Exception('Gagal Get outlet');
  //   }
  // }
}
