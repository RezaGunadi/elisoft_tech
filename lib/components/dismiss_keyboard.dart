import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// The DismissKeybaord widget (it's reusable)
class DismissKeyboard extends StatelessWidget {
  final Widget? child;
  const DismissKeyboard({Key? key,  this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}