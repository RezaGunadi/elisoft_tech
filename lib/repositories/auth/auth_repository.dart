import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

import '../../configs/base_url_config.dart';
import '../../configs/shared_prefence_manager.dart';
import '../../constants/injector.dart';
import '../../models/auth_detail.dart';
import '../../services/connection_service.dart';
import '../../services/storage/storage.dart';

class AuthRepository {
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  final SecureStorage _secureStorage = SecureStorage();
  String token = '';
  String tester = '';

  Future<void> getToken() async {
    tester = (await _secureStorage.getUserToken())!;
    // setState(() {
    if (tester != null) {
      token = tester!;
    }
    // });
  }
  //static //final facebookAppEvents = FacebookAppEvents();

  Future<AuthDetailModel> login(
    BuildContext context, {
    String name = '',
    String password = '',
    String email = '',
    String phone = '',
  }) async {
    var url = '${BaseUrlConfig.baseUrlApi}/auth/login';

    Uri uri = Uri.parse(url);
    print(uri);

    Map<String, dynamic> dataParam = {
      'email': email,
      'password': password,
      'bearer_token': 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB',
    };

    print(url);
    var response = await Provider.of<ConnectionService>(context, listen: false)
        .returnConnection()
        .post(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(dataParam));
    var data = json.decode(response.body);
    AuthDetailModel dataTournament = AuthDetailModel.fromJson(data);

    return dataTournament;
  }
}
