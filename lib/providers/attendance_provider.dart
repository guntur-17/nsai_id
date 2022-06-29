import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:nsai_id/models/attendance_model.dart';
import 'package:nsai_id/models/history_attendance_model.dart';
import 'package:nsai_id/services/attendance_service.dart';

class AttendanceProvider with ChangeNotifier {
  AttendanceModel? _data;

  AttendanceModel get data => _data as AttendanceModel;
  set data(AttendanceModel data) {
    _data = data;
    notifyListeners();
  }

  // AttendanceModel? _attendance;
  List<AttendanceModel> _attendances = [];
  List<AttendanceHistoryModel> _attendancesHistory = [];

  List<AttendanceModel> get attendances => _attendances;
  List<AttendanceHistoryModel> get attendancesHistory => _attendancesHistory;

  set attendances(List<AttendanceModel> attendances) {
    _attendances = attendances;
    notifyListeners();
  }

  set attendancesHistory(List<AttendanceHistoryModel> attendancesHistory) {
    _attendancesHistory = attendancesHistory;
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

  Future<bool> attendanceOut(
    String? token,
    String? time,
    double? lat,
    double? long,
  ) async {
    try {
      if (await AttendanceService().attendanceOut(token, time, lat, long)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> visitingPhoto(String? id, String? token, File? image,
      File? image2, List<Map<String, dynamic>> listItemTaken) async {
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
