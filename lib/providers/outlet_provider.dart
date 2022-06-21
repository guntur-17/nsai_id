// import 'package:absen_lite/models/shop_model.dart';
// import 'package:absen_lite/services/shop_service.dart';
import 'package:flutter/widgets.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';

import '../services/outlet_service.dart';

class OutletProvider with ChangeNotifier {
  List<OutletModel> _outlets = [];
  List<OutletModel> get outlets => _outlets;
  List<Map<String, dynamic>> _shopdistance = [];
  List<Map<String, dynamic>> get shopdistance => _shopdistance = [];

  set shopdistance(List<Map<String, dynamic>> shopdistance) {
    _shopdistance = shopdistance;
    notifyListeners();
  }

  set shops(List<OutletModel> outlets) {
    _outlets = outlets;
    notifyListeners();
  }

  Future<bool> getShops(String? token) async {
    try {
      List<OutletModel> outlets =
          await OutletService().getOutlets(token: token);
      _outlets = outlets;
      // print(_shops);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<bool> getShopDistance(
  //     String? token, double latUser, double longuser) async {
  //   try {
  //     List<Map<String, dynamic>> shopdistance = await OutletService()
  //         .getOutletsDistance(
  //             token: token, latUser: latUser, longUser: longuser);
  //     _shopdistance = shopdistance;
  //     // print(_shops)
  //     print(shopdistance);
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }
}
