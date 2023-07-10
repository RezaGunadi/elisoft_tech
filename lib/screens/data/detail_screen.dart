import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:child_care/models/device_list.dart';
import 'package:child_care/screens/login_screen.dart';
import 'package:child_care/screens/regis_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/custom_flutter_toast.dart';
import '../../components/loading_dialog_widget.dart';
import '../../constants/color.dart';
import '../../repositories/articles/articles_repository.dart';
import '../../services/storage/storage.dart';
import '../../utilities/dialog_helper.dart';
import '../home_screen.dart';

class DataDetailScreen extends StatefulWidget {
  static const routeName = '/data/detail';
  final Map<String, Object>? arguments;
  const DataDetailScreen({super.key, this.arguments});

  @override
  State<DataDetailScreen> createState() => DataDdetailScreenState();
}

class DataDdetailScreenState extends State<DataDetailScreen> {
  // final SharedPreferencesManager _sharedPreferencesManager =
  //     locator<SharedPreferencesManager>();
  String token = '';

  final SecureStorage _secureStorage = SecureStorage();
  ArticlesRepository deviceRepository = ArticlesRepository();

  final storage = const FlutterSecureStorage();
  String? tester = '';
  var data = new Articles();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map args = Get.arguments;
    if (args != null) {
      token = args['token'];
      data = args['data'];
    }
    // token = _secu
    // _getData();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      // _getData();
    });

    // token = _sharedPreferencesManager
    //     .getString(SharedPreferencesManager.keyMobileToken)
    //     .toString()
    //     .replaceAll("null", "");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorBase.softBlue,
        title: Text(
          data.title ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 16,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: screenHeight - 80,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    (data.content == null)
                        ? Column(
                            children: [
                              SizedBox(
                                height: screenHeight / 4,
                              ),
                              Container(
                                height: 150,
                                width: 150,
                                child: Image.asset(
                                  'assets/img/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth / 2,
                                child: const Text(
                                  'Artikel belum tersedia!',
                                  style: TextStyle(
                                    color: ColorBase.softBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  data.title.toString(),
                                  style: const TextStyle(
                                    color: ColorBase.black100,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                                  maxLines: 400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: (data.image != null)
                                          ? CachedNetworkImage(
                                              imageUrl: data.image!,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      'assets/img/logo.png'),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/img/logo.png',
                                              fit: BoxFit.cover,
                                            )),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  data.content.toString(),
                                  style: const TextStyle(
                                    color: ColorBase.black80,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                  maxLines: 400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Publisher",
                                          style: TextStyle(
                                            color: ColorBase.black60,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 1.4,
                                          ),
                                          maxLines: 400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(data.user!=null?
                                          data.user!.name!.toString(): 'Anonim',
                                          style: const TextStyle(
                                            color: ColorBase.black80,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 1.4,
                                          ),
                                          maxLines: 400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(data.user!=null?
                                          data.user!.email!.toString(): 'admin@elisoft.com',
                                          style: const TextStyle(
                                            color: ColorBase.black80,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 1.4,
                                          ),
                                          maxLines: 400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Date published",
                                          style: TextStyle(
                                            color: ColorBase.black60,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 1.4,
                                          ),
                                          maxLines: 400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(data.crated!=null?
                                          DateFormat('EEEE, MMMM dd yyyy').format(data.crated!.date!): '-',
                                          style: const TextStyle(
                                            color: ColorBase.black80,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 1.4,
                                          ),
                                          maxLines: 400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
