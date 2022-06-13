import 'dart:ffi';

class Item_taken {
  int? id;
  String? absent_id;
  String? product_id;
  String? item_taken;
  double? total_item_sold;
  int? sales_result;

  Item_taken({
    this.id,
    this.absent_id,
    this.product_id,
    this.item_taken,
    this.total_item_sold,
    this.sales_result,
  });

  Item_taken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    absent_id = json['absent_id'];
    product_id = json['product_id'];
    item_taken = json['item_taken'];
    total_item_sold = json['total_item_sold'];
    sales_result = json['sales_result'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'item_taken': item_taken,
        'product_id': product_id,
        'absent_id': absent_id,
        'total_item_sold': total_item_sold,
        'sales_result': sales_result,
      };
}
