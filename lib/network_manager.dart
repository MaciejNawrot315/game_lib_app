import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkManager {
  String baseUrl;

  NetworkManager({required this.baseUrl});
  Future<http.Response> sendRequest(
      String endpoint, Map<String, String> headers, String body) async {
    Uri url = Uri.https(baseUrl, '/$endpoint');
    return await http.post(url, headers: headers, body: body);
  }
}
