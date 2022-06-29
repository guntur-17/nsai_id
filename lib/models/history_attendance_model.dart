import 'package:nsai_id/models/item_taken_model.dart';
import 'package:nsai_id/models/product_model.dart';

class AttendanceHistoryModel {
  String? id;
  String? user_id;
  String? distributor_id;
  String? clock_in;
  String clock_out = "";
  String? address;
  String item_photo = "";
  String distributor_photo = "";
  List<ItemTakenModel> item = [];
  DateTime? createdAt;

  AttendanceHistoryModel({
    this.id,
    this.user_id,
    this.distributor_id,
    this.clock_in,
    this.clock_out = "",
    this.address,
    this.item_photo = "",
    this.distributor_photo = "",
    this.item = const [],
    this.createdAt,
  });

  AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    distributor_id = json['distributor_id'];
    clock_in = json['clock_in'];
    clock_out = json['clock_out'] ?? "";
    address = json['address'];
    item_photo = json['item_photo'] ?? "";
    distributor_photo = json['distributor_photo'] ?? "";
    item = json['item'] != null
        ? List<ItemTakenModel>.from(
            json['item'].map((x) => ItemTakenModel.fromJson(x)))
        : [];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'distributor_id': distributor_id,
      'clock_in': clock_in,
      'clock_out': clock_out,
      'address': address,
      'item_photo': item_photo,
      'distributor_photo': distributor_photo,
      // 'item': item?.toList(),
      'created_at': createdAt.toString(),
    };
  }
}
