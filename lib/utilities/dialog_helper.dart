
import 'package:flutter/material.dart';

import '../components/dialog/custom_confirm_alrt_dialog.dart';
import '../components/dialog/custom_confirm_alrt_info.dart';
import '../components/dialog/custom_confirm_dialog.dart';
import '../components/dialog/custom_confirm_with_textfield_dialog.dart';

class DialogHelper {
 

  static Future<bool> customConfirm(context,
      {required String title,
      required String description,
      required String leftButtonLabel,
      required String rightButtonLabel,
      bool confirmRightButton = true}) async {
    return await showDialog(
        context: context,
        builder: (context) => CustomConfirmDialog(
              title: title,
              description: description,
              leftButtonLabel: leftButtonLabel,
              rightButtonLabel: rightButtonLabel,
              confirmRightButton: confirmRightButton,
            ));
  }
  static Future<bool> customConfirmAlrt(context,
      {required String title,
      required String description,
       String? aditionalDescription,
      required String leftButtonLabel,
      required String rightButtonLabel,
      bool confirmRightButton = true}) async {
    return await showDialog(
        context: context,
        builder: (context) => CustomConfirmAlrtDialog(
              title: title,
              description: description,
              aditionalDescription: aditionalDescription??'',
              leftButtonLabel: leftButtonLabel,
              rightButtonLabel: rightButtonLabel,
              confirmRightButton: confirmRightButton,
            ));
  }
  static Future<bool> customConfirmInfo(context,
      {required String title,
      required String description,
      required String leftButtonLabel,
      required String rightButtonLabel,
      bool confirmRightButton = true}) async {
    return await showDialog(
        context: context,
        builder: (context) => CustomConfirmAlrtInfo(
              title: title,
              description: description,
              leftButtonLabel: leftButtonLabel,
              rightButtonLabel: rightButtonLabel,
              confirmRightButton: confirmRightButton,
            ));
  }

  static Future<Map<dynamic, dynamic>> customConfirmWithTextField(context,
      {required String title,
      required String description,
      required String leftButtonLabel,
      required String rightButtonLabel,
      required String textField,
      bool confirmRightButton = true}) async {
    return await showDialog(
        context: context,
        builder: (context) => CustomConfirmWithTextfieldDialog(
              title: title,
              description: description,
              leftButtonLabel: leftButtonLabel,
              rightButtonLabel: rightButtonLabel,
              confirmRightButton: confirmRightButton,
              textField: textField,
            ));
  }

}
