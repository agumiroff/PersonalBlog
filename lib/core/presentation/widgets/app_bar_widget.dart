import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final List<Widget>? actionButton;
  final Widget? leadingButton;
  const AppBarWidget({
    super.key,
    this.leadingButton,
    this.actionButton,
    required this.titleText,
  });
  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText ?? '', style: textStyles.headerText),
      centerTitle: true,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white,
      leadingWidth: 80.w,
      leading: leadingButton,
      actions: actionButton,
    );
  }
}
