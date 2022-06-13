import 'package:flutter/widgets.dart';
import 'package:nsai_id/models/region_model.dart';
import 'package:nsai_id/services/region_service.dart';

class RegionProvider with ChangeNotifier {
  // AttendanceModel? _attendance;
  List<RegionModel> _regions = [];

  List<RegionModel> get regions => _regions;
  // bool _checkConditionClock = true;

  // bool get checkConditionClock => _checkConditionClock;

  // set checkConditionClock(bool checkConditionClock) {
  //   _checkConditionClock = checkConditionClock;
  //   notifyListeners();
  // }

  set attendances(List<RegionModel> regions) {
    _regions = regions;
    notifyListeners();
  }

  Future<bool> getAttendances() async {
    try {
      List<RegionModel> regions = await RegionService().getRegion();
      _regions = regions;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
