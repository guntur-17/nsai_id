import 'dart:ffi';

class ItemTakenModel {
  String? id;
  String? absent_id;
  String? product_id;
  int? item_taken;
  int total_item_sold = 0;
  int sales_result = 0;
  DateTime? createdAt;

  ItemTakenModel({
    this.id,
    this.absent_id,
    this.product_id,
    this.item_taken,
    this.total_item_sold = 0,
    this.sales_result = 0,
    this.createdAt,
  });

  ItemTakenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    absent_id = json['absent_id'];
    product_id = json['product_id'];
    item_taken = json['item_taken'];
    total_item_sold = json['total_item_sold'] ?? 0;
    sales_result = json['sales_result'] ?? 0;
    createdAt = DateTime.parse(json['created_at']);
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
