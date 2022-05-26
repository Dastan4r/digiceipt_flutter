import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:localstorage/localstorage.dart';

import '../models/receipt_item_model.dart';

final LocalStorage storage = LocalStorage('mydigiceipts');
final String baseURL = FlutterConfig.get('URL');

class DigiceiptsProvider with ChangeNotifier {
  List<ReceiptModel> _digiceipts = [];

  get digiceipts {
    return [..._digiceipts];
  }

  Future<void> getDigiceipts() async {
    try {
      final url = Uri.parse('$baseURL/receipts?view=gallery&page=1&limit=20');

      final token = await storage.getItem('token');

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(url, headers: requestHeaders);

      final decodedResponse = json.decode(response.body)['data'];

      List<ReceiptModel> uncodedDigiceipts = [];

      for (var element in decodedResponse) {
        uncodedDigiceipts.add(ReceiptModel.fromJson(element as Map<String, dynamic>));
      }

      uncodedDigiceipts.removeWhere((element) => element.thumbnails.download_url == null);


      _digiceipts = uncodedDigiceipts;
    } catch (err) {
      print(err);
    }

    notifyListeners();
  }
}
