import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyles textStyles = TextStyles();

class TextStyles {
  TextStyle headerText = TextStyle(
    color: Colors.black,
    fontFamily: 'Noah',
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.02,
  );

  TextStyle logOutText = TextStyle(
    color: const Color(0xFFDD553D),
    fontFamily: 'Noah',
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.02,
  );

  TextStyle elevatedButtonText = TextStyle(
    color: const Color(0xFF121212),
    fontFamily: 'Noah',
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.02,
  );

  TextStyle textButtonText = TextStyle(
    color: Colors.blue,
    fontFamily: 'Noah',
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.02,
  );

  TextStyle labelStyle = TextStyle(
      color: const Color(0xFF9F9F9F),
      fontFamily: 'Noah',
      fontSize: 22.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.02);

  TextStyle dateStyle = TextStyle(
      color: const Color(0xFF9F9F9F),
      fontFamily: 'Noah',
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.02);

  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Noah',
    fontSize: 22.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.02,
  );
}
