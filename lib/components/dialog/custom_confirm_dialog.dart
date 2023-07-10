import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';

class CustomConfirmDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? leftButtonLabel;
  final String? rightButtonLabel;
  final bool confirmRightButton;

  const CustomConfirmDialog(
      {Key? key,
      this.title,
      this.description,
      this.leftButtonLabel,
      this.rightButtonLabel,
     required this.confirmRightButton})
      : super(key: key);
  
@override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(24),
      child: Stack(
        // overflow: Overflow.visible,
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$title',
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
                      '$description',
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              return Navigator.pop(
                                  context, confirmRightButton ? false : true);
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
                                  '$leftButtonLabel',
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
                                  '$rightButtonLabel',
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Colors.white,
                                    fontSize: ScreenUtil().scaleText*  14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context,
                                      confirmRightButton ? true : false);
                                },
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




                          ),
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _buildChild(BuildContext context) => ;
}
 