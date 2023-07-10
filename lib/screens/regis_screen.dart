import 'package:child_care/bloc/auth/auth_bloc.dart';
import 'package:child_care/constants/color.dart';
import 'package:child_care/screens/home_screen.dart';
import 'package:child_care/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/custom_flutter_toast.dart';
import '../components/loading_dialog_widget.dart';
import '../configs/shared_prefence_manager.dart';
import '../constants/injector.dart';
import '../models/auth_detail.dart';
import '../repositories/auth/auth_repository.dart';
import '../repositories/articles/articles_repository.dart';
import '../services/storage/storage.dart';
import '../utilities/dialog_helper.dart';

class RegistScreen extends StatefulWidget {
  static const routeName = '/regist';
  const RegistScreen({super.key});

  @override
  State<RegistScreen> createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  String password = '';
  String email = '';
  String name = '';
  String phone = '';
  AuthRepository authRepository = AuthRepository();

  final SecureStorage _secureStorage = SecureStorage();
  // AuthBloc authBloc= AuthBloc();

  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  ArticlesRepository deviceRepository = ArticlesRepository();
  String currentName = '';
  String currentPhone = '';
  String currentEmail = '';
  String helpText = '';
  bool obscureText = true;
  var helpController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    // authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        bool? result = await _onBackPressed(context);
        if (result == null) {
          result = false;
        } else if (result) {
          return true;
        } else {
          return false;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorBase.softBlue,
          title: Text(
            'Registration',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),

          // leading: null,
          // leading: IconButton(
          //     onPressed: () async {
          //       bool? result = await _onBackPressed(context);
          //       if (result == null) {
          //         result = false;
          //       }
          //       // return result;
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
                      // BlocListener<AuthBloc, AuthState>(
                      //   bloc: authBloc,
                      //   listener: (context, state) {
                      //     if (state is AuthRegistSuccess) {

                      //       Navigator.pop(context);

                      //       _sharedPreferencesManager.putString(
                      //           SharedPreferencesManager.keyMobileToken,
                      //           state.saveOrder.token.toString());

                      //       Navigator.pushNamed(context, HomeScreen.routeName);

                      //       customFlutterToast(
                      //         context: context,
                      //         msg: 'Berhasil Mendaftar',
                      //         customToastType: CustomToastType.SUCCESS,
                      //       );
                      //     }
                      //     if (state is AuthRegistFailure) {
                      //       customFlutterToast(
                      //         context: context,
                      //         msg: state.error,
                      //         customToastType: CustomToastType.ERROR,
                      //       );
                      //     }
                      //   },
                      // ),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              height: width / 3,
                              width: width / 3,
                              child: Image.asset(
                                'assets/img/logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Make new Account',
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
                            // hintText: 'Eli Soft ',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorBase.black60)),
                            labelText: 'Name'),
                        onChanged: (value) {
                          if (value != null) {
                            name = value;
                          } else {
                            name = '';
                          }
                        },
                        onSaved: (newValue) {
                          if (newValue == null) {
                            name = '';
                          } else {
                            name = newValue;
                          }
                        },
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
                            // hintText: '123456',
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
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorBase.softBlue)),
                            // hintText: '08XXXXXXXX',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorBase.black60)),
                            labelText: 'Phone'),
                        onChanged: (value) {
                          if (value != null) {
                            phone = value;
                          } else {
                            phone = '';
                          }
                        },
                        onSaved: (newValue) {
                          if (newValue == null) {
                            phone = '';
                          } else {
                            phone = newValue;
                          }
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            'Sudah punya akun?',
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
                                  context, LoginScreen.routeName);
                            },
                            child: Text(
                              'Klik disini',
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
                          var confirm = await DialogHelper.customConfirmAlrt(
                              context,
                              title: 'Registrasi',
                              description:
                                  'Semua data yang di masukan akan menjadi milik kami dan kami memiliki hak penuh atas data data tersebut',
                              leftButtonLabel: 'Tidak',
                              rightButtonLabel: 'Ya, Saya Setuju!');
                          if (confirm) {
                            AuthDetailModel responseApi =
                                await authRepository.login(context,
                                    email: email,
                                    name: name,
                                    password: password,
                                    phone: phone);
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
                                      context, HomeScreen.routeName,
                                      arguments: {
                                        'token': responseApi.data?.uuid
                                      });

                                  customFlutterToast(
                                    context: context,
                                    msg: 'Berhasil Mendaftar',
                                    customToastType: CustomToastType.SUCCESS,
                                  );
                                } else {
                                  LoadingDialogWidget.hide(context);
                                  customFlutterToast(
                                    context: context,
                                    msg: 'Gagal, silahkan coba lagi',
                                    customToastType: CustomToastType.ERROR,
                                  );
                                }
                              } else {
                                LoadingDialogWidget.hide(context);
                                customFlutterToast(
                                  context: context,
                                  msg:
                                      'Gagal Mendaftarkan akun, silahkan coba lagi',
                                  customToastType: CustomToastType.ERROR,
                                );
                              }
                            } else {
                              LoadingDialogWidget.hide(context);
                              customFlutterToast(
                                context: context,
                                msg:
                                    'Gagal Mendaftarkan akun, silahkan coba lagi',
                                customToastType: CustomToastType.ERROR,
                              );
                            }
                          }
                          //   authBloc.add(AuthRegistEvent(context,
                          //       email: email,
                          //       name: name,
                          //       password: password,
                          //       phone: phone));
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
                            'Daftar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).viewInsets.bottom,
                      // )
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
