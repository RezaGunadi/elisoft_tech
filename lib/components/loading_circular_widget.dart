import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetCircularLoading extends StatelessWidget {
  final Color _backgroundColor;
  final String _loadingDesctiption;

  WidgetCircularLoading(this._backgroundColor, this._loadingDesctiption);
  
 
@override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: _backgroundColor,
      child: Column(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
          Center(
            child: Text(_loadingDesctiption),
          ),
        ],
      ),
    );
  }
}
