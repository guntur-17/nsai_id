class DocumentModel {
  String? id;
  String? user_id;
  String? name;
  String? file;
  DateTime? createdAt;

  DocumentModel({
    this.id,
    this.user_id,
    this.name,
    this.file,
    this.createdAt,
  });

  DocumentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    name = json['name'];
    file = json['file'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'name': name,
      'file': file,
      'created_at': createdAt.toString(),
    };
  }
}
