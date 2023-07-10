import 'package:child_care/screens/regis_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/custom_flutter_toast.dart';
import '../components/loading_dialog_widget.dart';
import '../constants/color.dart';
import '../models/auth_detail.dart';
import '../repositories/auth/auth_repository.dart';
import '../repositories/articles/articles_repository.dart';
import '../services/storage/storage.dart';
import '../utilities/dialog_helper.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = '';
  String email = '';
  AuthRepository authRepository = AuthRepository();
  final SecureStorage _secureStorage = SecureStorage();

  ArticlesRepository deviceRepository = ArticlesRepository();
  String currentName = '';
  String currentPhone = '';
  String currentEmail = '';
  String helpText = '';
  bool obscureText = true;
  var helpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        bool? result = await _onBackPressed(context);
        if (result == null) {
          return result = false;
        } else if (result) {
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorBase.softBlue,
          title: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          // leading: IconButton(
          //     onPressed: () async {
          //       bool? result = await _onBackPressed(context);
          //       if (result == null) {
          //         result = false;
          //       }
          //     },
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //       size: 16,
          //     )),
          actions: [
            GestureDetector(
              onTap: () {
                // getToken();

                helpModal(context, width);
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
          ],
        ),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                  width: width,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorBase.black10),
                      boxShadow: [
                        BoxShadow(
                          color: ColorBase.black10,
                          blurRadius: 8,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              height: width / 3,
                              width: width / 3,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/img/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Elisoft System',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorBase.softBlue)),
                            hintText: 'example@elisoft.com',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorBase.black60)),
                            labelText: 'Email'),
                        onChanged: (value) {
                          if (value != null) {
                            email = value;
                          } else {
                            email = '';
                          }
                        },
                        onSaved: (newValue) {
                          if (newValue == null) {
                            email = '';
                          } else {
                            email = newValue;
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: obscureText,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                child: Icon(Icons.remove_red_eye_rounded)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorBase.softBlue)),
                            // hintText: '',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorBase.black60)),
                            labelText: 'Password'),
                        onChanged: (value) {
                          if (value != null) {
                            password = value;
                          } else {
                            password = '';
                          }
                        },
                        onSaved: (newValue) {
                          if (newValue == null) {
                            password = '';
                          } else {
                            password = newValue;
                          }
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            'Belum punya akun?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, RegistScreen.routeName);
                            },
                            child: Text(
                              'Daftar disini',
                              style: TextStyle(
                                color: ColorBase.softBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () async {
                          LoadingDialogWidget.show(context);
                          AuthDetailModel responseApi =
                              await authRepository.login(
                            context,
                            email: email,
                            password: password,
                          );
                          if (responseApi != null) {
                            if (responseApi.data != null) {
                              if (responseApi.data?.uuid != null) {
                                AuthDetail data = responseApi.data!;

                                // _sharedPreferencesManager.putString(
                                //     SharedPreferencesManager.keyMobileToken,
                                //     data.token.toString());
                                _secureStorage.setUserToken(
                                    (responseApi.data?.uuid).toString());
                                _secureStorage.setUserName(
                                    (responseApi.data?.name).toString());
                                _secureStorage.setUserPhone(
                                    (responseApi.data?.phone_number)
                                        .toString());
                                _secureStorage.setUserEmail(
                                    (responseApi.data?.email).toString());
                                LoadingDialogWidget.hide(context);
                                Navigator.pop(context);

                                Navigator.pushNamed(
                                    context, HomeScreen.routeName, arguments: {
                                  'token': responseApi.data?.uuid
                                });

                                customFlutterToast(
                                  context: context,
                                  msg: responseApi.message ??
                                      'Connection time out, please try again!',
                                  customToastType: CustomToastType.SUCCESS,
                                );
                              } else {
                                LoadingDialogWidget.hide(context);
                                customFlutterToast(
                                  context: context,
                                  msg: responseApi.message ??
                                      'Connection time out, please try again!',
                                  customToastType: CustomToastType.ERROR,
                                );
                              }
                            } else {
                              LoadingDialogWidget.hide(context);
                              customFlutterToast(
                                context: context,
                                msg: responseApi.message ??
                                    'Connection time out, please try again!',
                                customToastType: CustomToastType.ERROR,
                              );
                            }
                          } else {
                            customFlutterToast(
                              context: context,
                              msg:
                                  'Gagal Mendaftarkan akun, silahkan coba lagi',
                              customToastType: CustomToastType.ERROR,
                            );
                          }
                        },
                        child: Container(
                          width: width,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: ColorBase.softBlue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  // Text(
                  //   'wwwwwwwwwwwwwwwwwwwwwwwwww',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w500,
                  //     height: 1.4,
                  //   ),
                  // ),
                  ),
            ),
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
                            minLines: 3,
                            maxLines: 12,
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
                              LoadingDialogWidget.show(context);
                              // BasicResponseModel responseApi =
                              //     await deviceRepository.helpRequest(context,
                              //         email: currentEmail,
                              //         name: currentName,
                              //         phone: currentPhone,
                              //         message: helpController.text,
                              //         token: '');
                              // modalSetState(
                              //   () {
                              //     setState(() {
                              //       if (responseApi == null) {
                              //         LoadingDialogWidget.hide(context);
                              //         customFlutterToast(
                              //           context: context,
                              //           msg:
                              //               'Gagal mengirim pesan, silahkan coba lagi',
                              //           customToastType: CustomToastType.ERROR,
                              //         );
                              //       } else {
                              //         if (responseApi.statusCode == 200) {
                              //           LoadingDialogWidget.hide(context);
                              //           customFlutterToast(
                              //             context: context,
                              //             msg: 'Pesan berhasil di kirim',
                              //             customToastType:
                              //                 CustomToastType.SUCCESS,
                              //           );
                              //         } else {
                              //           LoadingDialogWidget.hide(context);
                              //           customFlutterToast(
                              //             context: context,
                              //             msg:
                              //                 'Gagal mengirim pesan, silahkan coba lagi',
                              //             customToastType:
                              //                 CustomToastType.ERROR,
                              //           );
                              //         }
                              //       }
                              //     });
                              //   },
                              // );
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
