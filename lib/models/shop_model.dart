// class ShopModel {
//   int? id;
//   String? name;
//   String? address;
//   double? lat;
//   double? long;

//   ShopModel({
//     this.id,
//     this.name,
//     this.address,
//     this.lat,
//     this.long,
//   });

//   ShopModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     address = json['address'];
//     lat = json['lat'];
//     long = json['long'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();

//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['lat'] = this.lat;
//     data['long'] = this.long;
//     return data;
//   }
// }

class ShopModel {
  final int id;
  final String name;
  final String address;
  final double lat;
  final double long;

  ShopModel({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        lat: json['lat'],
        long: json['long'],
      );
  // id = json['id'];
  // name = json['name'];
  // address = json['address'];
  // lat = json['lat'];
  // long = json['long'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'lat': lat,
        'long': long,
      };
}
