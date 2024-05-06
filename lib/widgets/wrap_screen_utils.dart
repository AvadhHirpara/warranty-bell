import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WrapScreenUtils extends StatelessWidget {
  final Widget child;

  const WrapScreenUtils({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child1){
        ScreenUtil.init(context);
        return child;
      },
    );
  }
}
