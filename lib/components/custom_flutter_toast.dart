import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CustomToastType {
  SUCCESS,
  ERROR,
  INFO,
}
void customFlutterToast({
  required BuildContext context,
  required String msg,
  CustomToastType? customToastType,
  int duration = 2,
}) {
   FToast fToast = FToast();
   fToast.init(context);
  //fToast.removeCustomToast();

  double screenWidth = MediaQuery.of(context).size.width;
  Widget toast = Container(
    width: screenWidth,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: customToastType == CustomToastType.SUCCESS
          ? Color.fromRGBO(0, 196, 140, 0.9)
          : customToastType == CustomToastType.ERROR
              ? Color.fromRGBO(255, 4, 4, 0.9)
              : Color.fromRGBO(37, 40, 43, 0.9),
    ),
    child: (customToastType == CustomToastType.SUCCESS)
        ? Text(
            msg,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Rubik',
              fontSize: ScreenUtil().scaleText*  12,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth - 122,
                child: Text(
                  msg,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Rubik',
                    fontSize: ScreenUtil().scaleText*  12,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  fToast.removeCustomToast();
                },
                child: Text(
                  'Tutup',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Rubik',
                    fontSize: ScreenUtil().scaleText*  12,
                  ),
                ),
              ),
            ],
          ),
  );

  if (customToastType == CustomToastType.SUCCESS) {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
    );
  } else {
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 10),
    );
  }
}
