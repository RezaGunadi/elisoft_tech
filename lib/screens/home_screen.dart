import 'package:cached_network_image/cached_network_image.dart';
import 'package:child_care/screens/login_screen.dart';
import 'package:child_care/screens/regis_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';

import '../bloc/articles/articles_bloc.dart';
import '../components/custom_flutter_toast.dart';
import '../components/loading_dialog_widget.dart';
import '../configs/shared_prefence_manager.dart';
import '../constants/color.dart';
import '../constants/injector.dart';
import '../models/auth_detail.dart';
import '../models/device_list.dart';
import '../repositories/auth/auth_repository.dart';
import '../repositories/articles/articles_repository.dart';
import '../services/storage/storage.dart';
import '../utilities/dialog_helper.dart';
import 'data/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  final Map<String, Object>? arguments;
  const HomeScreen({super.key, this.arguments});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();
  String token = '';
  ArticlesBloc articleBloc = new ArticlesBloc();

  final SecureStorage _secureStorage = SecureStorage();
  ArticlesRepository articleRepository = ArticlesRepository();
  AuthRepository authRepository = AuthRepository();

  final storage = const FlutterSecureStorage();
  String? tester = '';
  bool isEmpty = true;
  String articleName = '';
  String articleAddress = '';
  // ArticlesListModel articleList = ArticlesListModel();
  List<Articles> articleList = [];
  String currentName = '';
  String currentPhone = '';
  String currentEmail = '';
  var helpController = TextEditingController();
  String helpText = '';
  String newPassword = '';
  String currentPassword = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map args = Get.arguments;
    if (args != null) {
      token = args['token'] ?? token;
    }
    // token = _secureStorage.getUserToken() as String;
    if (token == null || token == 'token') {
      token = '';
    }
    articleBloc = BlocProvider.of<ArticlesBloc>(context);

    articleBloc.add(ArticlesListEvent(context, token: token));
    _getData();
  }

  Future<dynamic> _getData() async {
    articleBloc.add(ArticlesListEvent(context, token: token));
    _getDataManual();
  }

  Future<dynamic> _getDataManual() async {
    ArticlesListModel responseApi =
        await articleRepository.getArticles(context, rememberToken: token);
    if (responseApi != null) {
      if (responseApi.data != null) {
        if (responseApi.data!.length > 0) {
          if (responseApi.data![0].title != null) {
            setState(() {
              isEmpty = false;
              articleList.addAll(responseApi.data!);
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        bool? result = await _onBackPressed(context);
        if (result == null) {
          return false;
        } else if (result) {
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorBase.softBlue,
          title: const Text(
            'Elisoft Tech',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          leading: IconButton(
              onPressed: () async {
                bool? result = await _onBackPressed(context);
                if (result == null) {
                  result = false;
                } else if (result) {
                  true;
                } else {
                  false;
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 16,
              )),
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    helpModal(context, screenWidth);
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Icon(Icons.help_outline_rounded),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      color: Colors.white,
                      width: 1,
                      height: 20,
                    )),
                GestureDetector(
                  onTap: () async {
                    // getToken();

                    if (token == '') {
                      bool result = await DialogHelper.customConfirm(
                        context,
                        title: 'Apakah anda sudah memiliki akun?',
                        description:
                            'Apabila anda belum memiliki akun anda dapat mendaftarkan diri anda, pastikan data diri sesuai!',
                        leftButtonLabel: 'Belum',
                        rightButtonLabel: 'Ya, Sudah',
                        confirmRightButton: true,
                      );
                      if (result) {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      } else {
                        Navigator.pushNamed(context, RegistScreen.routeName);
                      }
                    } else {
                      profileModal(context);
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Icon(Icons.account_circle_sharp),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
          // bottom:isEmpty?null:
          //  PreferredSize(
          //   preferredSize: Size.fromHeight(20),
          //   child: GestureDetector(
          //     onTap: () {
          //       _getData();
          //     },
          //     child: Container(

          //       alignment: Alignment.center,
          //       width: screenWidth - 32,
          //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //       decoration: BoxDecoration(
          //           border: Border.all(color: ColorBase.black40),
          //           color: ColorBase.primaryWhite,
          //           borderRadius: BorderRadius.circular(12)),
          //       child: Text(
          //         'Tambah Perangkat',
          //         style: TextStyle(
          //           color: ColorBase.black80,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w500,
          //           height: 1.4,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ),
        body: Container(
          // RefreshIndicator(
          //   onRefresh: () =>

          //       // setState(() {
          //       _getData()
          //   // });
          //   ,
          child: Column(
            children: [
              BlocListener<ArticlesBloc, ArticlesState>(
                  bloc: articleBloc,
                  listenWhen: (previous, current) {
                    if (current is ArticlesListSuccess ||
                        current is ArticlesListFailure) {
                      return true;
                    }
                    return false;
                  },
                  listener: (context, state) {
                    if (state is ArticlesListSuccess) {
                      setState(() {
                        articleList.clear();
                        articleList = state.data;
                        if (articleList.isNotEmpty) {
                          isEmpty = false;
                        }
                      });
                    }
                    if (state is ArticlesListFailure) {
                      _getData();
                    }
                  },
                  child: SizedBox()),
              Container(
                height: (screenHeight - 80) * 0.22,
                color: Colors.white,
                width: screenWidth,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < articleList.length; i++)
                        // if (articleList[i].crated == null)
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DataDetailScreen.routeName,
                                arguments: {
                                  'token': token,
                                  'data': articleList[i],
                                });
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 8, top: 2 * 8, left: 16, right: 16),
                              decoration: BoxDecoration(
                                color: ColorBase.primaryWhite,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  const BoxShadow(
                                    spreadRadius: 1,
                                    color: Color.fromRGBO(0, 0, 0, 0.07),
                                    offset: Offset(0, 0),
                                  )
                                ],
                                border: Border.all(color: ColorBase.mildBlue),
                              ),
                              // padding: const EdgeInsets.symmetric(
                              //     vertical: 12, horizontal: 16),
                              width: screenWidth * 0.62,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: (screenWidth) * 0.62,
                                          child: Text(
                                            articleList[i].title.toString(),
                                            style: const TextStyle(
                                              color: ColorBase.mildBlue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              height: 1.4,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),

                                        SizedBox(
                                          height: 4,
                                        ),
                                        // Divider(
                                        //   color: ColorBase.black10,
                                        // ),
                                        // SizedBox(
                                        //   height: 4,
                                        // ),
                                        Container(
                                          width: screenWidth * 0.62,
                                          child: Text(
                                            articleList[i].content.toString(),
                                            style: const TextStyle(
                                              color: ColorBase.black80,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              height: 1.4,
                                            ),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 4,
                                        // ),
                                        // Divider(
                                        //   color: ColorBase.black10,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                height: (isEmpty == true)
                    ? (screenHeight - 80)
                    : (screenHeight - 80) * 0.78,
                color: Colors.white,
                alignment: Alignment.center,
                child: (isEmpty == true)
                    ? Column(
                        children: [
                          SizedBox(
                            height: screenHeight / 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _getData();
                              });
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset(
                                'assets/img/logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            // SizedBox(
                            //   height: screenHeight / 4,
                            // ),
                            for (int i = 0; i < articleList.length; i++)
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DataDetailScreen.routeName,
                                      arguments: {
                                        'token': token,
                                        'data': articleList[i],
                                      });
                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      color: ColorBase.lightBlue,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        const BoxShadow(
                                          spreadRadius: 1,
                                          color: Color.fromRGBO(0, 0, 0, 0.07),
                                          offset: Offset(0, 0),
                                        )
                                      ],
                                      border:
                                          Border.all(color: ColorBase.black10),
                                    ),
                                    // padding: const EdgeInsets.symmetric(
                                    //     vertical: 12, horizontal: 16),
                                    width: screenWidth - 32,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: (screenWidth - 82) *
                                                        1 /
                                                        3,
                                                    height: (screenWidth - 82) *
                                                        1 /
                                                        3,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      // BorderRadius.vertical(top: Radius.circular(8) ),
                                                      child: (articleList[i]
                                                                  .image !=
                                                              null)
                                                          ? CachedNetworkImage(
                                                              imageUrl:
                                                                  articleList[i]
                                                                      .image!,
                                                              progressIndicatorBuilder: (context,
                                                                      url,
                                                                      downloadProgress) =>
                                                                  CircularProgressIndicator(
                                                                      value: downloadProgress
                                                                          .progress),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                      'assets/img/logo.png'),
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.asset(
                                                              'assets/img/logo.png',
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 16),
                                                  Container(
                                                    width: (screenWidth - 82) *
                                                        2 /
                                                        3,
                                                    child: Text(
                                                      articleList[i]
                                                          .title
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.4,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: 4,
                                              ),
                                              // Divider(
                                              //   color: ColorBase.black10,
                                              // ),
                                              // SizedBox(
                                              //   height: 4,
                                              // ),
                                              Container(
                                                width: screenWidth - 64,
                                                child: Text(
                                                  articleList[i]
                                                      .content
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: ColorBase.black80,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.4,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              // SizedBox(
                                              //   height: 4,
                                              // ),
                                              // Divider(
                                              //   color: ColorBase.black10,
                                              // ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 2),
                                                        width: (screenWidth -
                                                                100) /
                                                            2,
                                                        child: Text(
                                                          'Author',
                                                          style:
                                                              const TextStyle(
                                                            color: ColorBase
                                                                .black80,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.4,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: (screenWidth -
                                                                100) /
                                                            2,
                                                        child: Text(
                                                          articleList[i]
                                                                  .user!
                                                                  .name ??
                                                              "Anonim",
                                                          style:
                                                              const TextStyle(
                                                            color: ColorBase
                                                                .black80,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.4,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 2),
                                                        width: (screenWidth -
                                                                100) /
                                                            2,
                                                        child: Text(
                                                          'Published',
                                                          style:
                                                              const TextStyle(
                                                            color: ColorBase
                                                                .black80,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.4,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: (screenWidth -
                                                                100) /
                                                            2,
                                                        child: Text(
                                                          articleList[i]
                                                                      .crated !=
                                                                  null
                                                              ? articleList[i]
                                                                          .crated!
                                                                          .date !=
                                                                      null
                                                                  ? DateFormat(
                                                                          'EEE, d MMM yyyy')
                                                                      .format(articleList[
                                                                              i]
                                                                          .crated!
                                                                          .date!)
                                                                  : 'Unknown'
                                                              : 'Unknown',
                                                          style:
                                                              const TextStyle(
                                                            color: ColorBase
                                                                .black80,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.4,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            // SizedBox(
                            //   height: 40,
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     _getData();
                            //   },
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     width: screenWidth-32,
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 16, vertical: 8),
                            //     decoration: BoxDecoration(
                            //         border: Border.all(color: ColorBase.black40),
                            //         color: ColorBase.primaryWhite,
                            //         borderRadius: BorderRadius.circular(12)),
                            //     child: Text(
                            //       'Tambah Perangkat',
                            //       style: TextStyle(
                            //         color: ColorBase.black80,
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w500,
                            //         height: 1.4,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _onBackPressed(context) async {
    bool result = await DialogHelper.customConfirm(
      context,
      title: 'Apakah yakin untuk keluar?',
      description: 'Pastikan untuk mengingat id dan passwordnya ya',
      leftButtonLabel: 'Tidak',
      rightButtonLabel: 'Ya, Keluar',
      confirmRightButton: true,
    );
    if (result) {
      Navigator.pop(context);
      // Navigator.pop(context);
      return true;
    } else {
      return false;
    }
  }

  void changePasswordModal(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter modalSetState) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 16),
                          width: 40,
                          height: 4.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ubah Kata Sandi',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 18,
                                  fontWeight: FontWeight.w500,
                                  color: ColorBase.black100,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: ColorBase.black80,
                                    size: 18,
                                  )
                                  // Text(
                                  //   'Log Out',
                                  //   style: TextStyle(
                                  //     fontFamily: 'Rubik',
                                  //     fontSize: ScreenUtil().scaleText * 14,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: ColorBase.softBlue,
                                  //   ),
                                  // ),
                                  ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            onChanged: (value) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentPassword = value;
                                  });
                                },
                              );
                            },
                            onSaved: (newValue) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentPassword = newValue!;
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan Kata Sandi Lama',
                              label: Text(
                                'Kata Sandi Lama',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            onChanged: (value) {
                              modalSetState(
                                () {
                                  setState(() {
                                    newPassword = value;
                                  });
                                },
                              );
                            },
                            onSaved: (newValue) {
                              modalSetState(
                                () {
                                  setState(() {
                                    newPassword = newValue!;
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan kata sandi baru',
                              label: Text(
                                'Kata Sandi Baru',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              customFlutterToast(
                                  context: context,
                                  msg: "Coming soon",
                                  customToastType: CustomToastType.INFO);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              decoration: BoxDecoration(
                                color: ColorBase.softBlue,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Color.fromRGBO(0, 0, 0, 0.09))
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Ubah',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.primaryWhite,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).whenComplete(() {});
  }

  void profileModal(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter modalSetState) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 16),
                          width: 40,
                          height: 4.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Profile',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 18,
                                  fontWeight: FontWeight.w500,
                                  color: ColorBase.black100,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    bool result2 =
                                        await DialogHelper.customConfirm(
                                      context,
                                      title: 'Apakah anda ingin keluar',
                                      description:
                                          'Pastikan untuk mengingat id dan passwordnya ya',
                                      leftButtonLabel: 'Tidak',
                                      rightButtonLabel: 'Ya, Keluar',
                                      confirmRightButton: true,
                                    );
                                    if (result2) {
                                      // Navigator.pushNamed(context, LoginScreen.routeName);
                                      // setState(() async {
                                      // await storage.deleteAll();

                                      // await storage.delete(key: 'username');
                                      // await storage.delete(key: 'phone');
                                      // await storage.delete(key: 'token');
                                      setState(() {
                                        _secureStorage.deleteAll();
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, LoginScreen.routeName);
                                      });
                                      // _secureStorage.
                                      // _sharedPreferencesManager
                                      //     .clearKey(SharedPreferencesManager.keyMobileToken);
                                      // _sharedPreferencesManager
                                      //     .clearKey(SharedPreferencesManager.keyUsername);
                                      // _sharedPreferencesManager
                                      //     .clearKey(SharedPreferencesManager.keyUserPhone);
                                      // });
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.logout_rounded,
                                    color: ColorBase.softBlue,
                                    size: 18,
                                  )
                                  // Text(
                                  //   'Log Out',
                                  //   style: TextStyle(
                                  //     fontFamily: 'Rubik',
                                  //     fontSize: ScreenUtil().scaleText * 14,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: ColorBase.softBlue,
                                  //   ),
                                  // ),
                                  ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            initialValue: currentName,
                            onChanged: (value) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentName = value;
                                  });
                                },
                              );
                            },
                            onSaved: (newValue) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentName = newValue!;
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan nama pengguna',
                              label: Text(
                                'Name',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: currentEmail,
                            onChanged: (value) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentEmail = value;
                                  });
                                },
                              );
                            },
                            onSaved: (newValue) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentEmail = newValue!;
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan E-mail pengguna',
                              label: Text(
                                'E-mail',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: currentPhone,
                            onChanged: (value) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentPhone = value;
                                  });
                                },
                              );
                            },
                            onSaved: (newValue) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentPhone = newValue!;
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan Nomor Ponsel pengguna',
                              label: Text(
                                'Nomor Ponsel',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              changePasswordModal(context);
                            },
                            child: Text(
                              'Ubah Password',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: ScreenUtil().scaleText * 14,
                                fontWeight: FontWeight.w400,
                                color: ColorBase.black80,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () async {
                              customFlutterToast(
                                  context: context,
                                  msg: "Coming soon",
                                  customToastType: CustomToastType.INFO);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pushNamed(context, HomeScreen.routeName,
                                  arguments: {'uuid': token});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              decoration: BoxDecoration(
                                color: ColorBase.softBlue,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Color.fromRGBO(0, 0, 0, 0.09))
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Simpan',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.primaryWhite,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).whenComplete(() {});
  }

  void helpModal(context, double screenWidth) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter modalSetState) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 16),
                          width: 40,
                          height: 4.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jelaskan kendala anda',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 18,
                                  fontWeight: FontWeight.w500,
                                  color: ColorBase.black100,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            initialValue: currentName,
                            onChanged: (value) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentName = value;
                                  });
                                },
                              );
                            },
                            onSaved: (newValue) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentName = newValue!;
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan nama pengguna',
                              label: Text(
                                'Name',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: currentEmail,
                            onChanged: (value) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentEmail = value;
                                  });
                                },
                              );
                            },
                            onSaved: (newValue) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentEmail = newValue!;
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan E-mail pengguna',
                              label: Text(
                                'E-mail',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: currentPhone,
                            onChanged: (value) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentPhone = value;
                                  });
                                },
                              );
                            },
                            onSaved: (newValue) {
                              modalSetState(
                                () {
                                  setState(() {
                                    currentPhone = newValue!;
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan Nomor Ponsel pengguna',
                              label: Text(
                                'Nomor Ponsel',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: helpController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Jelaskan kendala anda',
                              label: Text(
                                'Kendala',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.black60,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.black80),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: ColorBase.softBlue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: screenWidth * 3 / 4,
                            child: Text(
                              'Pastikan data data di isi dengan benar! kami akan menghubungi anda maksimal 1x24 jam',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: ScreenUtil().scaleText * 12,
                                fontWeight: FontWeight.w400,
                                color: ColorBase.black80,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              decoration: BoxDecoration(
                                color: ColorBase.softBlue,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Color.fromRGBO(0, 0, 0, 0.09))
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Kirim',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: ScreenUtil().scaleText * 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorBase.primaryWhite,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).whenComplete(() {});
  }
}
