import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';

class CustomConfirmWithTextfieldDialog extends StatefulWidget {
  final String? title;
  final String? description;
  final String? leftButtonLabel;
  final String? rightButtonLabel;
  final bool confirmRightButton;
  final String? textField;

  const CustomConfirmWithTextfieldDialog(
      {Key? key,
      this.title,
      this.description,
      this.leftButtonLabel,
      this.rightButtonLabel,
      required this.confirmRightButton,
      this.textField})
      : super(key: key);

  @override
  _CustomConfirmWithTextfieldDialogState createState() =>
      _CustomConfirmWithTextfieldDialogState();
}

class _CustomConfirmWithTextfieldDialogState
    extends State<CustomConfirmWithTextfieldDialog> {
  var textController = TextEditingController();
  Map<dynamic, dynamic> returnValue = {
    'isConfirm': false,
    'textField': 'string'
  };

  @override
    void setState(fn) {
      if(mounted) {
        super.setState(fn);
      }
    }
   
@override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 10,
        height: 245,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(24),
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.title}',
                  style: TextStyle(
                    fontSize: ScreenUtil().scaleText*  18,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    '${widget.description}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenUtil().scaleText*  14,
                        height: 1.5,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 48,
                  child: TextField(
                    controller: textController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.5, vertical: 8),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorBase.black10,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorBase.black10,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      labelText: widget.textField,
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(37, 40, 43, 1),
                        fontSize: ScreenUtil().scaleText*  12,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              returnValue['isConfirm'] =
                                  widget.confirmRightButton ? false : true;
                              returnValue['textField'] = textController.text;
                            });
                            Navigator.pop(context, returnValue);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorBase.softBlue, width: 1),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                '${widget.leftButtonLabel}',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: ColorBase.softBlue,
                                  fontSize: ScreenUtil().scaleText*  14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: ElevatedButton(
                              child: Text(
                                '${widget.rightButtonLabel}',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: ScreenUtil().scaleText*  14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(ColorBase.softBlue),
                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: BorderSide(color: ColorBase.softBlue)

                                      )
                                  )
                              ),
                              onPressed: () {
                                setState(() {
                                  returnValue['isConfirm'] =
                                      widget.confirmRightButton ? true : false;
                                  returnValue['textField'] =
                                      textController.text;
                                });
                                Navigator.pop(context, returnValue);
                              },
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
