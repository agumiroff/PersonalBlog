import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';

class TextFieldWidget extends StatelessWidget {
  final bool isPassword;
  final TextEditingController textEditingController;
  final VoidCallback? onTap;
  final String labelText;
  final String suffixText;
  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.suffixText,
    required this.onTap,
    required this.textEditingController,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335.w,
      height: 68.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            obscureText: isPassword,
            controller: textEditingController,
            style: TextStyle(fontSize: 18.sp),
            decoration: InputDecoration(
              floatingLabelStyle: textStyles.textStyle,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: labelText,
              labelStyle: textStyles.labelStyle,
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12.h),
              suffixIcon: GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding:  EdgeInsets.only(top: 37.h),
                  child: Text(
                    suffixText,
                    style: TextStyle(
                        color: const Color(0xFF01A8E9),
                        fontFamily: 'Noah',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.02.sp),
                  ),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: const Color(0xFFF2F2F2), width: 2.h, style: BorderStyle.solid),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: const Color(0xFFF2F2F2), width: 2.h, style: BorderStyle.solid),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: const Color(0xFFF2F2F2), width: 2.h, style: BorderStyle.solid),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
