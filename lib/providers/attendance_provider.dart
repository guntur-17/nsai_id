import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:nsai_id/models/attendance_model.dart';
import 'package:nsai_id/models/history_attendance_model.dart';
import 'package:nsai_id/services/attendance_service.dart';

class AttendanceProvider with ChangeNotifier {
  AttendanceModel? _data;
  AttendanceHistoryModel? _dataHistory;

  AttendanceModel get data => _data as AttendanceModel;
  set data(AttendanceModel data) {
    _data = data;
    notifyListeners();
  }

  AttendanceHistoryModel get dataHistory =>
      _dataHistory as AttendanceHistoryModel;
  set dataHistory(AttendanceHistoryModel data) {
    _dataHistory = data;
    notifyListeners();
  }

  // AttendanceModel? _attendance;
  List<AttendanceModel> _attendances = [];
  List<AttendanceHistoryModel> _attendancesHistory = [];
  List<AttendanceHistoryModel> _itemTaken = [];

  List<AttendanceModel> get attendances => _attendances;
  List<AttendanceHistoryModel> get attendancesHistory => _attendancesHistory;
  List<AttendanceHistoryModel> get itemTaken => _itemTaken;

  set attendances(List<AttendanceModel> attendances) {
    _attendances = attendances;
    notifyListeners();
  }

  set attendancesHistory(List<AttendanceHistoryModel> attendancesHistory) {
    _attendancesHistory = attendancesHistory;
    notifyListeners();
  }

  set itemTaken(List<AttendanceHistoryModel> itemTaken) {
    _itemTaken = itemTaken;
    notifyListeners();
  }

  // Future<bool> getAttendances(String? token) async {
  //   try {
  //     List<AttendanceModel> attendances =
  //         await AttendanceService().getAttendances(token);
  //     _attendances = attendances;
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<bool> getAttendancesHistory(String? token, String? id) async {
    try {
      List<AttendanceHistoryModel> attendanceHistory =
          await AttendanceService().getAttendancesHistory(token: token, id: id);
      _attendancesHistory = attendanceHistory;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getItemTaken(String? token, String? id) async {
    try {
      List<AttendanceHistoryModel> itemTaken =
          await AttendanceService().getItemTaken(token: token, id: id);
      _itemTaken = itemTaken;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> attendanceIn(
      {String? token,
      String? distributor_id,
      String? clock_in,
      String? address}) async {
    try {
      AttendanceModel data = await AttendanceService().attendanceIn(
          token: token,
          distributor_id: distributor_id,
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

  Future<bool> attendanceOut({
    String? id,
    String? token,
    String? time,
  }) async {
    try {
      AttendanceModel data = await AttendanceService()
          .attendanceOut(time: time, token: token, id: id);
      // _dataHistory = dataHistory;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> absentPhoto(String? id, String? token, File? image, File? image2,
      List<Map<String, dynamic>> listItemTaken) async {
    try {
      if (await AttendanceService()
          .absentPhoto(id, token, image, image2, listItemTaken)) {
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
