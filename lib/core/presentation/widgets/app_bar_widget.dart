import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actionButton;
  final Widget? leadingButton;
  const AppBarWidget({
    super.key,
    this.leadingButton,
    this.actionButton,
  });
  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leadingWidth: 80.w,
      leading: leadingButton,
      actions: actionButton,
    );
  }
}
