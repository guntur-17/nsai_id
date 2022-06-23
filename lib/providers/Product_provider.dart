import 'package:flutter/material.dart';
import 'package:nsai_id/models/product_model.dart';
import 'package:nsai_id/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<bool> getProduct(String? token, String? distributorId) async {
    try {
      products = await ProductService()
          .getProducts(token: token, distributor_id: distributorId);
      _products = products;
      // print(_products);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
