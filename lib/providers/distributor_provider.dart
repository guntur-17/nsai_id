import 'package:flutter/widgets.dart';
import 'package:nsai_id/models/distributor_model.dart';
import 'package:nsai_id/services/distributor_service.dart';

class DistributorProvider with ChangeNotifier {
  // AttendanceModel? _attendance;
  List<DistributorModel> _distributors = [];

  List<DistributorModel> get distributors => _distributors;
  // bool _checkConditionClock = true;

  // bool get checkConditionClock => _checkConditionClock;

  // set checkConditionClock(bool checkConditionClock) {
  //   _checkConditionClock = checkConditionClock;
  //   notifyListeners();
  // }

  set attendances(List<DistributorModel> distributors) {
    _distributors = distributors;
    notifyListeners();
  }

  Future<bool> getDistributors(String? token) async {
    try {
      List<DistributorModel> distributors =
          await DistributorService().getDistributors(token: token);
      _distributors = distributors;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  // Future<bool> login({String? username, String? password}) async {
  //   try {
  //     UserModel user =
  //         await AuthService().login(username: username, password: password);
  //     _user = user;
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

}
