// // class ShopModel {
// //   int? id;
// //   String? name;
// //   String? address;
// //   double? lat;
// //   double? long;

// //   ShopModel({
// //     this.id,
// //     this.name,
// //     this.address,
// //     this.lat,
// //     this.long,
// //   });

// //   ShopModel.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = json['name'];
// //     address = json['address'];
// //     lat = json['lat'];
// //     long = json['long'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();

// //     data['id'] = this.id;
// //     data['name'] = this.name;
// //     data['address'] = this.address;
// //     data['lat'] = this.lat;
// //     data['long'] = this.long;
// //     return data;
// //   }
// // }

// import 'package:nsai_id/models/shop_model.dart';

// class ShopDistanceModel {
//   final ShopModel shop;
//   final int distance;

//   ShopDistanceModel({
//     required this.shop,
//     required this.distance,
//   });

//   factory ShopDistanceModel.fromJson(
//           Map<ShopModel, dynamic> json, Map<double, dynamic> distance) =>
//       ShopDistanceModel(
//         shop: json['shop'],
//         distance: distance['distance'],
//       );
//   // id = json['id'];
//   // name = json['name'];
//   // address = json['address'];
//   // lat = json['lat'];
//   // long = json['long'];

//   Map<String, dynamic> toJson() => {
//         'shop': shop,
//         'distance': distance,
//       };
// }
