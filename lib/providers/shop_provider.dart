// import 'package:absen_lite/models/shop_model.dart';
// import 'package:absen_lite/services/shop_service.dart';
import 'package:flutter/widgets.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/shop_model.dart';

import '../services/shop_service.dart';

class ShopProvider with ChangeNotifier {
  List<ShopModel> _shops = [];
  List<ShopModel> get shops => _shops;
  List<ShopDistanceModel> _shopdistance = [];
  List<ShopDistanceModel> get shopdistance => _shopdistance = [];

  set shopdistance(List<ShopDistanceModel> shopdistance) {
    _shopdistance = shopdistance;
    notifyListeners();
  }

  set shops(List<ShopModel> shops) {
    _shops = shops;
    notifyListeners();
  }

  Future<bool> getShops(String? token) async {
    try {
      List<ShopModel> shops = await ShopService().getShops(token: token);
      _shops = shops;
      // print(_shops);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
