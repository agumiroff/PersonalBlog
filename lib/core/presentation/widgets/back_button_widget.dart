
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  const BackButtonWidget({
    Key? key, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 100.w,
        height: 36.h,
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: Colors.black,
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.arrow_left,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  'BACK',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                )
              ],
            )),
      ),
    );
  }
}
