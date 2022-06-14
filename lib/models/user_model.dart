// class UserModel {
//   int? id;
//   String? nik;
//   String? name;
//   String? email;
//   String? username;
//   String? password;
//   String? gender;
//   String? photo;
//   String? access_token;

//   UserModel({
//     this.id,
//     this.nik,
//     this.name,
//     this.email,
//     this.username,
//     this.password,
//     this.gender,
//     this.photo,
//     this.access_token,
//   });

//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nik = json['nik'];
//     name = json['name'];
//     email = json['email'];
//     username = json['username'];
//     password = json['password'];
//     gender = json['gender'];
//     photo = json['photo'];
//     access_token = json['access_token'];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'nik': nik,
//       'name': name,
//       'email': email,
//       'username': username,
//       'password': password,
//       'gender': gender,
//       'photo': photo,
//       'access_token': access_token,
//     };
//   }
// }

class UserModel {
  String? id;
  String? id_card_number;
  String? full_name;
  String? email;
  String? password;
  String? region;
  String? role;
  String? nick_name;
  String? access_token;

  UserModel({
    this.id,
    this.id_card_number,
    this.full_name,
    this.email,
    this.password,
    this.region,
    this.role,
    this.nick_name,
    this.access_token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id_card_number = json['id_card_number'];
    full_name = json['full_name'];
    email = json['email'];
    password = json['password'];
    region = json['region'];
    role = json['role'];
    nick_name = json['nick_name'];
    access_token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_card_number': id_card_number,
      'full_name': full_name,
      'email': email,
      'password': password,
      'region': region,
      'role': role,
      'nick_name': nick_name,
      'access_token': access_token,
    };
  }
}
