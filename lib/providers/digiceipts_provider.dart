import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/receipt_item_model.dart';
import '../models/upload_receipt_model.dart';
import '../helpers/shared_preference.dart';

final String? baseURL = dotenv.env['URL'];

class DigiceiptsProvider with ChangeNotifier {
  List<ReceiptModel> _digiceipts = [];
  String? nextUrl;
  bool lastPage = false;

  get digiceipts {
    return [..._digiceipts];
  }

  Future<void> getDigiceipts() async {
    try {
      final url = Uri.parse('$baseURL/receipts?view=gallery&page=1&limit=15');

      String? _token = await SharedPreferenceController().getString('token');

      if(_token != null) {
              Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        };

        final response = await http.get(url, headers: requestHeaders);

        final decodedResponse = json.decode(response.body);

        List<ReceiptModel> uncodedDigiceipts = [];

        for (var element in decodedResponse['data']) {
          uncodedDigiceipts.add(ReceiptModel.fromJson(element as Map<String, dynamic>));
        }

        uncodedDigiceipts.removeWhere((element) => element.thumbnails.download_url == null || element.receipt.download_url == null);

        _digiceipts = uncodedDigiceipts;

        if(decodedResponse['next_url'] != null) {
          nextUrl = decodedResponse['next_url'];
          lastPage = false;
        } else {
          nextUrl = null;
          lastPage = true;
        }
      }

    } catch (err) {
      print(err);
    }

    notifyListeners();
  }

  Future<void> getDigiceiptsMore() async {
    try {
      if(nextUrl != null) {
        final url = Uri.parse(nextUrl.toString());

        final _token = await SharedPreferenceController().getString('token');

        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        };

        final response = await http.get(url, headers: requestHeaders);

        final decodedResponse = json.decode(response.body);

        List<ReceiptModel> uncodedDigiceipts = [];

        for (var element in decodedResponse['data']) {
          uncodedDigiceipts.add(ReceiptModel.fromJson(element as Map<String, dynamic>));
        }

        uncodedDigiceipts.removeWhere((element) => element.thumbnails.download_url == null);

        _digiceipts = [..._digiceipts, ...uncodedDigiceipts];

        if(decodedResponse['next_url'] != null) {
          nextUrl = decodedResponse['next_url'];
          lastPage = false;
        } else {
          nextUrl = null;
          lastPage = true;
        }
      }
    } catch (err) {
      print(err);
    }

    notifyListeners();
  }

  Future<void> uploadDigiceipts(List data) async {
    try {
      final url = Uri.parse('$baseURL/receipts');

      final _token = await SharedPreferenceController().getString('token');

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      };

      Map params = {
        'camera': {
          "camera_details": null
        },
        'data': data
      };

      await http.post(url, headers: requestHeaders, body: json.encode(params));
    } catch(err) {
      print(err);
    }

    notifyListeners();
  }
}
