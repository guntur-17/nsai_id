import 'package:nsai_id/models/document_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DocumentService {
  String baseUrl = 'http://nsa-api.sakataguna-dev.com/api';
  Future<List<DocumentModel>> getDocument({String? token}) async {
    var url = Uri.parse('$baseUrl/document');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token as String
    };

    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data);
      List<DocumentModel> documents = [];

      for (var item in data) {
        documents.add(DocumentModel.fromJson(item));
      }

      return documents;
    } else {
      throw Exception('Gagal Get document');
    }
  }
}
