class RegionModel {
  String? id;
  String? name;

  RegionModel({
    this.id,
    this.name,
  });

  RegionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
