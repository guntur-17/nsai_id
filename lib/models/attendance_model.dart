class AttendanceModel {
  int? id;
  int? user_id;
  String? type;
  String? time;
  double? lat;
  double? long;
  DateTime? createdAt;

  AttendanceModel({
    this.id,
    this.user_id,
    this.type,
    this.time,
    this.lat,
    this.long,
    this.createdAt,
  });

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    type = json['type'];
    time = json['time'];
    lat = json['lat'];
    long = json['long'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'type': type,
      'time': time,
      'lat': lat,
      'long': long,
      'created_at': createdAt.toString(),
    };
  }
}
