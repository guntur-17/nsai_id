class VisitingModel {
  String? id;
  String? user_id;
  String? outlet_id;
  String? clock_in;
  String? address;
  DateTime? createdAt;

  VisitingModel({
    this.id,
    this.user_id,
    this.outlet_id,
    this.clock_in,
    this.address,
    this.createdAt,
  });

  VisitingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    outlet_id = json['outlet_id'];
    clock_in = json['clock_in'];
    address = json['address'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'outlet_id': outlet_id,
      'clock_in': clock_in,
      'address': address,
      'created_at': createdAt.toString(),
    };
  }
}
