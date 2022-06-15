import 'package:flutter/widgets.dart';
import 'package:nsai_id/models/user_model.dart';
import 'package:nsai_id/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user as UserModel;
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> login({String? email, String? password}) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register({
    String? full_name,
    String? nick_name,
    String? id_card_number,
    String? region_id,
    String? email,
    String? password,
  }) async {
    try {
      if (await AuthService().register(
          full_name, nick_name, id_card_number, region_id, email, password)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout({String? token}) async {
    try {
      if (await AuthService().logout(token)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      print('salah provider');
      return false;
    }
  }

  Future<bool> getUser({String? token, String? id}) async {
    try {
      UserModel user = await AuthService().getUser(token, id);

      _user = user;
      return true;
    } catch (e) {
      print('salah getuser');
      return false;
    }
  }
}

// class AuthProvider with ChangeNotifier {
//   UserModel? _user;

//   UserModel get user => _user as UserModel;
//   set user(UserModel user) {
//     _user = user;
//     notifyListeners();
//   }

//   Future<bool> login({String? email, String? password}) async {
//     try {
//       UserModel user =
//           await AuthService().login(username: email, password: password);

//       _user = user;
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   Future<bool> logout({String? token}) async {
//     try {
//       if (await AuthService().logout(token)) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(e);
//       print('salah provider');
//       return false;
//     }
//   }

//   Future<bool> getUser({String? token}) async {
//     try {
//       UserModel user = await AuthService().getUser(token);

//       _user = user;
//       return true;
//     } catch (e) {
//       print('salah getuser');
//       return false;
//     }
//   }
// }
