import 'dart:ffi';

class Product {
  int? id;
  String? name;
  String? unit;
  double? price;
  int? taken;

  Product({
    this.id,
    this.name,
    this.unit,
    this.price,
    this.taken,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unit = json['unit'];
    price = json['price'];
    taken = json['taken'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'unit': unit,
        'name': name,
        'price': price,
        'taken': taken,
      };
}
