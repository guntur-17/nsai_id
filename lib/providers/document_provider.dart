import 'package:flutter/widgets.dart';
import 'package:nsai_id/services/document_service.dart';

import '../models/document_model.dart';

class DocumentProvider with ChangeNotifier {
  List<DocumentModel> _documents = [];

  List<DocumentModel> get documents => _documents;

  set documents(List<DocumentModel> documents) {
    _documents = documents;
    notifyListeners();
  }

  Future<bool> getDocuments(String? token) async {
    try {
      List<DocumentModel> documents =
          await DocumentService().getDocument(token: token);
      _documents = documents;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
