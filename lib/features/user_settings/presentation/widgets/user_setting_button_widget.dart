import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';

class UserSettingsButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const UserSettingsButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 335.w,
        height: 60.h,
        child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: const Color(0xFFF2F2F2)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
              child: Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: textStyles.elevatedButtonText,
                  ),
                  const Spacer(),
                  const Icon(Icons.message)
                ],
              ),
            )),
      ),
    );
  }
}
