import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';
import 'package:personal_blog/features/add_post/presentation/bloc/add_post_bloc.dart';

class PreviewPost extends StatelessWidget {
  final Uint8List image;
  final String postDescription;
  const PreviewPost({
    super.key,
    required this.image,
    required this.postDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SafeArea(
              child: Text(
            'Post preview',
            style: textStyles.headerText,
          )),
          Row(children: [
            TextButton(
                onPressed: () {
                  BlocProvider.of<AddPostBloc>(context).add(PickPhotoEvent(postDescription: postDescription));
                },
                child: Text(
                  'Cancel',
                  style: textStyles.textButtonText,
                )),
            const Spacer(),
            TextButton(
                onPressed: () {
                  BlocProvider.of<AddPostBloc>(context)
                      .add(AddPostEvent(pickedPhoto: image, postDescription: postDescription));
                },
                child: Text(
                  'Post',
                  style: textStyles.textButtonText,
                )),
          ]),
          SizedBox(height: 20.h),
          SizedBox(
              height: 400.h,
              width: 400.w,
              child: Image.memory(
                image,
                fit: BoxFit.cover,
              )),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            width: 345.w,
            child: SingleChildScrollView(child: Text(postDescription, style: textStyles.textStyle)),
          )
        ],
      ),
    );
  }
}
