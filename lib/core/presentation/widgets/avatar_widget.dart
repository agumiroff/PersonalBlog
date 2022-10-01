import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/styles.dart';

class AvatarWidget extends StatelessWidget {
  final String text;
  const AvatarWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(
            color: const Color(0xFFF2F2F2),
            width: 4,
          )),
      width: 143.w,
      height: 143.h,
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.blue,
          child: Text(
            text,
            style: textStyles.headerText,
          )),
    );
  }
}
