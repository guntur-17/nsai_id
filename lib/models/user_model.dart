class UserModel {
  int? id;
  String? nik;
  String? name;
  String? email;
  String? username;
  String? password;
  String? gender;
  String? photo;
  String? access_token;

  UserModel({
    this.id,
    this.nik,
    this.name,
    this.email,
    this.username,
    this.password,
    this.gender,
    this.photo,
    this.access_token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    photo = json['photo'];
    access_token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'email': email,
      'username': username,
      'password': password,
      'gender': gender,
      'photo': photo,
      'access_token': access_token,
    };
  }
}
