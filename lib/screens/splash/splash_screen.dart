import 'dart:async';
import 'dart:convert';
import 'package:child_care/constants/color.dart';
import 'package:child_care/screens/home_screen.dart';
import 'package:child_care/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/injector.dart';
import '../../configs/shared_prefence_manager.dart';
import '../../services/storage/storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  String token = '';
  String? tester = '';

  final SecureStorage _secureStorage = SecureStorage();
  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    super.initState();
    if (token == null || token == 'token') {
      token = '';
    }
    getToken();
    
    Timer(Duration(seconds: 2), () {
      // print("Yeah, this line is printed after 3 seconds");
      if (token == '') {
        Navigator.pushNamed(context, LoginScreen.routeName);
      } else {

      Navigator.pushNamed(context, HomeScreen.routeName,arguments: {
        'token' : token
      });
      }
    });
    // Timer.periodic(Duration(seconds: 2),(timer) {
      
    //     if (token == '') {
    //       Navigator.pushNamed(context, LoginScreen.routeName);
    //     } else {
    //       Navigator.pushNamed(context, HomeScreen.routeName);
    //     }
    // },);
  }

  Future<void> getToken() async {
    tester = await _secureStorage.getUserToken();
    setState(() {
      token = tester!;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double heightScreen = mediaQueryData.size.height;

    double screenWidth = mediaQueryData.size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          
          if (token == '') {
            Navigator.pushNamed(context, LoginScreen.routeName);
          } else {
            Navigator.pushNamed(context, HomeScreen.routeName);
          }
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorBase.black5,
          alignment: Alignment.center,
          child: Image.asset('assets/img/logo.png', height: screenWidth / 2),
        ),
      ),
    );
  }
}
