import 'dart:ffi';

import 'package:nsai_id/models/product_model.dart';

class VisitingSalesModel {
  String? id;
  String? visit_id;
  String? product_id;
  int? item_sold;
  int? total_sales;
  DateTime? createdAt;
  ProductModel? product;

  VisitingSalesModel({
    this.id,
    this.visit_id,
    this.product_id,
    this.item_sold,
    this.total_sales,
    this.createdAt,
    this.product,
  });

  VisitingSalesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visit_id = json['visit_id'];
    product_id = json['product_id'];
    item_sold = json['item_sold'];
    total_sales = json['total_sales'];
    createdAt = DateTime.parse(json['created_at']);
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'item_sold': item_sold,
        'product_id': product_id,
        'visit_id': visit_id,
        'total_sales': total_sales,
        'created_at': createdAt.toString(),
      };
}
