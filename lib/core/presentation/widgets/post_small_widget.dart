import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostSmallPreview extends StatelessWidget {
  final Uint8List postImage;
  final String postDescription;
  final Timestamp timestamp;
  const PostSmallPreview({Key? key, required this.postImage, required this.postDescription, required this.timestamp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Image.memory(postImage),
          SizedBox(height: 10.h,),
          Text(postDescription),

        ],
      ),
    );
  }
}
