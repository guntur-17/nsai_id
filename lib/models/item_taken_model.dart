import 'dart:ffi';

import 'package:nsai_id/models/product_model.dart';

class ItemTakenModel {
  String? id;
  String? absent_id;
  String? product_id;
  int? item_taken;
  int? total_item_sold;
  int? sales_result;
  DateTime? createdAt;
  ProductModel? product;

  ItemTakenModel({
    this.id,
    this.absent_id,
    this.product_id,
    this.item_taken,
    this.total_item_sold,
    this.sales_result,
    this.createdAt,
    this.product,
  });

  ItemTakenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    absent_id = json['absent_id'];
    product_id = json['product_id'];
    item_taken = json['item_taken'];
    total_item_sold = json['total_item_sold'];
    sales_result = json['sales_result'];
    createdAt = DateTime.parse(json['created_at']);
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'item_taken': item_taken,
        'product_id': product_id,
        'absent_id': absent_id,
        'total_item_sold': total_item_sold,
        'sales_result': sales_result,
        'created_at': createdAt.toString(),
      };
}
