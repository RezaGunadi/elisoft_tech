import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/retry.dart';

class ConnectionService with ChangeNotifier {
  final http.Client _client = RetryClient(http.Client());
  

  http.Client returnConnection() {
    
    return _client;
  }

  
}