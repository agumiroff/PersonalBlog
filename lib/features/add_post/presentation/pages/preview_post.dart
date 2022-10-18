import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';
import 'package:personal_blog/core/presentation/widgets/app_bar_widget.dart';
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
    return Scaffold(
      appBar: AppBarWidget(
        actionButton: [PostButton(image: image, postDescription: postDescription)],
        leadingButton: CancelButton(postDescription: postDescription),
      ),
      body: Column(
        children: [
          SafeArea(
              child: Text(
            'Post preview',
            style: textStyles.headerText,
          )),
          SizedBox(height: 20.h),
          SizedBox(
              height: 400.h,
              width: 400.w,
              child: Image(image: MemoryImage(image), fit: BoxFit.cover,)),
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

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
    required this.postDescription,
  }) : super(key: key);

  final String postDescription;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<AddPostBloc>(context).add(PickPhotoEvent(postDescription: postDescription));
        },
        child: Text(
          'Cancel',
          style: textStyles.textButtonText,
        ));
  }
}

class PostButton extends StatelessWidget {
  const PostButton({
    Key? key,
    required this.image,
    required this.postDescription,
  }) : super(key: key);

  final Uint8List image;
  final String postDescription;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<AddPostBloc>(context).add(AddPostEvent(pickedPhoto: image, postDescription: postDescription));
        },
        child: Text(
          'Post',
          style: textStyles.textButtonText,
        ));
  }
}
