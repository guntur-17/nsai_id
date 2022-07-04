import 'package:nsai_id/models/distributor_model.dart';
import 'package:nsai_id/models/item_taken_model.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/models/product_model.dart';
import 'package:nsai_id/models/visiting_sales_model.dart';

class VisitingHistoryModel {
  String? id;
  String? user_id;
  String? outlet_id;
  OutletModel? outlet;
  String? clock_in;
  String? address;
  String? item_photo;
  String? outlet_photo;
  String? other_photo;
  List<VisitingSalesModel>? item;
  DateTime? createdAt;

  VisitingHistoryModel({
    this.id,
    this.user_id,
    this.outlet_id,
    this.outlet,
    this.clock_in,
    this.address,
    this.item_photo,
    this.outlet_photo,
    this.other_photo,
    this.item,
    this.createdAt,
  });

  VisitingHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    outlet = OutletModel.fromJson(json['outlet']);
    outlet_id = json['outlet_id'];
    clock_in = json['clock_in'];
    address = json['address'];
    item_photo = json['item_photo'];
    outlet_photo = json['outlet_photo'];
    other_photo = json['other_photo'];
    item = List<VisitingSalesModel>.from(
        json['item'].map((x) => VisitingSalesModel.fromJson(x)));
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'outlet_id': outlet_id,
      'outlet': outlet!.toJson(),
      'clock_in': clock_in,
      'address': address,
      'item_photo': item_photo,
      'outlet_photo': outlet_photo,
      'other_photo': other_photo,
      // 'item': item!.toJson(),
      'created_at': createdAt.toString(),
    };
  }
}
