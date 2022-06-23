class AttendanceModel {
  String? id;
  String? user_id;
  String? distributor_id;
  String? clock_in;
  String? address;
  DateTime? createdAt;

  AttendanceModel({
    this.id,
    this.user_id,
    this.distributor_id,
    this.clock_in,
    this.address,
    this.createdAt,
  });

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    distributor_id = json['distributor_id'];
    clock_in = json['clock_in'];
    address = json['address'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'distributor_id': distributor_id,
      'clock_in': clock_in,
      'address': address,
      'created_at': createdAt.toString(),
    };
  }
}
