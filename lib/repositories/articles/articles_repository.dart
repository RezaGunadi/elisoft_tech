import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

import '../../configs/base_url_config.dart';
import '../../configs/shared_prefence_manager.dart';
import '../../constants/injector.dart';
import '../../models/auth_detail.dart';
import '../../models/device_list.dart';
import '../../services/connection_service.dart';
import '../../services/storage/storage.dart';

class ArticlesRepository {
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  final SecureStorage _secureStorage = SecureStorage();
  String token = '';
  String tester = '';

  get message => null;

  Future<void> getToken() async {
    tester = (await _secureStorage.getUserToken())!;
    // setState(() {
    if (tester != null) {
      token = tester!;
    }
    // });
  }

  Future<ArticlesListModel> getArticles(
    BuildContext context, {
    String rememberToken = '',
    String userName = '',
    String password = '',
    String usernameOrEmail = '',
  }) async {
    getToken();

    print(token);
    print('token');
    if (rememberToken != '') {
      token = rememberToken;
    }
    // var query = '?mobile_token=' +
    //     _sharedPreferencesManager
    //         .getString(SharedPreferencesManager.keyMobileToken).toString().replaceAll("null","");
    // var query = '?name=${name.toString().replaceAll("null", "")}';

    var url = '${BaseUrlConfig.baseUrlApi}/articles?token$token';
    url = url + "userName" + userName;
    url = url + "password" + password;
    url = url + "usernameOrEmail" + usernameOrEmail;
    url += '&bearer_token=lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB';
    Uri uri = Uri.parse(url);
    print(uri);
    var response = await Provider.of<ConnectionService>(context, listen: false)
        .returnConnection()
        .get(uri);

    // var response  = await Dio().post(
    //   Uri.encodeFull(url),
    //   data: query,
    //   // options: Options(headers: headers ?? getHeaders()
    //   // ),
    // );
    var data = json.decode(response.body);
    print(data);
    ArticlesListModel realData = ArticlesListModel.fromJson(data);
    print(realData);

    return realData;
  }
}
