import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';

class PostView extends StatelessWidget {
  final String postImage;
  final String postDescription;
  final Timestamp dateTime;
  const PostView({Key? key, required this.postImage, required this.postDescription, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('sdsad'),
            SizedBox(height: 10.h),
            SizedBox(
              width: 375.w,
              height: 400.h,
              child: Image.network(postImage, fit: BoxFit.cover),
            ),
            SizedBox(height: 10.h),
            Text(postDescription, style: textStyles.textStyle),
            SizedBox(height: 10.h),
            Text(dateTime.toDate().toUtc().toString(), style: textStyles.dateStyle),
          ],
        ),
      ),
    );
  }
}
