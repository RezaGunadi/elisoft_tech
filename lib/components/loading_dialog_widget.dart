import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_flutter_toast.dart';

class LoadingDialogWidget extends StatelessWidget {
  static void show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(const Duration(seconds: 15), () {
            Navigator.pop(context);
            customFlutterToast(
              context: context,
              msg: 'Gagal mengakses server. Silakan cek koneksi anda',
              customToastType: CustomToastType.ERROR,
            );
          });
          return const LoadingDialogWidget();
        },
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialogWidget({super.key});

  
@override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(
              strokeWidth: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}
