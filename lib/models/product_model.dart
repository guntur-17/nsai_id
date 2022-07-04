import 'dart:ffi';

class ProductModel {
  String? id;
  String? distributor_id;
  String? name;
  String? unit;
  int? price;

  ProductModel({
    this.id,
    this.distributor_id,
    this.name,
    this.unit,
    this.price,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distributor_id = json['distributor_id'];
    name = json['name'];
    unit = json['unit'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'distributor_id': distributor_id,
        'unit': unit,
        'name': name,
        'price': price,
      };
}
