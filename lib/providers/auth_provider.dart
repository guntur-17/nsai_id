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

  Future<bool> login({String? username, String? password}) async {
    try {
      UserModel user =
          await AuthService().login(username: username, password: password);

      _user = user;
      return true;
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

  Future<bool> getUser({String? token}) async {
    try {
      UserModel user = await AuthService().getUser(token);

      _user = user;
      return true;
    } catch (e) {
      print('salah getuser');
      return false;
    }
  }
}
