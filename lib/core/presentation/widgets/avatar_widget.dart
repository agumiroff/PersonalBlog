import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarWidget extends StatelessWidget {
  final String avatarLink;
  final VoidCallback onTap;
  final String text;
  const AvatarWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required this.avatarLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 120.h,
          width: 120.w,
          child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(avatarLink), fit: BoxFit.cover),
                border: Border.all(color: Colors.grey, width: 1),
                shape: BoxShape.circle),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.add_circle,
              size: 30,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
