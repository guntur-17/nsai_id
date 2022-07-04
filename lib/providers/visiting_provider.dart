import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:nsai_id/models/visiting_history_model.dart';
import 'package:nsai_id/models/visiting_model.dart';
import 'package:nsai_id/services/visiting_service.dart';

class VisitingProvider with ChangeNotifier {
  VisitingModel? _data;

  VisitingModel get data => _data as VisitingModel;
  set data(VisitingModel data) {
    _data = data;
    notifyListeners();
  }

  // AttendanceModel? _attendance;
  List<VisitingModel> _visitings = [];
  List<VisitingHistoryModel> _visitingsHistory = [];

  List<VisitingModel> get visitings => _visitings;
  List<VisitingHistoryModel> get visitingsHistory => _visitingsHistory;
  // bool _checkConditionClock = true;

  // bool get checkConditionClock => _checkConditionClock;

  // set checkConditionClock(bool checkConditionClock) {
  //   _checkConditionClock = checkConditionClock;
  //   notifyListeners();
  // }

  set visitings(List<VisitingModel> visitings) {
    _visitings = visitings;
    notifyListeners();
  }

  set visitingsHistory(List<VisitingHistoryModel> visitingsHistory) {
    _visitingsHistory = visitingsHistory;
    notifyListeners();
  }

  Future<bool> getVisitingHistory(String? token, String? id) async {
    try {
      List<VisitingHistoryModel> visitingsHistory =
          await VisitingService().getVisitingHistory(token: token, id: id);
      _visitingsHistory = visitingsHistory;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getVisiting(String? token, String? id) async {
    try {
      List<VisitingModel> visitings =
          await VisitingService().getVisiting(token, id);
      _visitings = visitings;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> visitingIn(
      {String? token,
      String? outlet_id,
      String? clock_in,
      String? address}) async {
    try {
      VisitingModel data = await VisitingService().visitingIn(
          token: token,
          outlet_id: outlet_id,
          clock_in: clock_in,
          address: address);
      _data = data;
      // if (await AttendanceService().attendanceIn(token, time, lat, long)) {

      // } else {
      //   return false;
      // }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> visitingOut(
    String? token,
    String? time,
    String? id,
    double? lat,
    double? long,
  ) async {
    try {
      if (await VisitingService().visitingOut(token, time, id, lat, long)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> visitingPhoto(
      String? id,
      String? token,
      File? image,
      File? image2,
      File? image3,
      List<Map<String, dynamic>> listItemTaken) async {
    try {
      if (await VisitingService()
          .visitingPhoto(id, token, image, image2, image3, listItemTaken)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("gagal provider photo");
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
