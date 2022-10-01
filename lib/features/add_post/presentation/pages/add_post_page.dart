import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';
import 'package:personal_blog/features/add_post/domain/use_cases/add_post.dart';
import 'package:personal_blog/features/add_post/domain/use_cases/select_image.dart';
import 'package:personal_blog/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:personal_blog/features/add_post/presentation/pages/preview_post.dart';

import '../../../../core/presentation/widgets/image_box.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image;
    TextEditingController postDescription = TextEditingController();
    AddPostUseCase addPostUseCase = AddPostUseCase();
    SelectImage selectImage = SelectImage();
    AddPostBloc addPostBloc = BlocProvider.of<AddPostBloc>(context);
    var photoUrl = '';
    Uint8List imagePhoto;
    return BlocBuilder<AddPostBloc, AddPostStates>(builder: (context, state) {
      if (state is AddPostStartState) {
        return Material(
          child: SingleChildScrollView(
            child: Column(children: [
              const SafeArea(child: SizedBox.shrink()),
              Stack(children: [
                state.image == null
                    ? SizedBox(
                        height: 400.h,
                        width: 375.w,
                        child: const Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/empty_photo.jpg'),
                        ),
                      )
                    : SizedBox(
                        height: 400.h,
                        width: 375.w,
                        child: SingleChildScrollView(
                          child: Image.memory(
                            state.image!,
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                Positioned(
                  right: 10.w,
                  top: 340.h,
                  child: GestureDetector(
                    onTap: () async {
                      image = await selectImage.pickImageFromGallery();
                      addPostBloc.add(PickPhotoEvent(pickedPhoto: image, postDescription: postDescription.text));
                    },
                    child: Icon(
                      Icons.add_a_photo,
                      size: 50.h,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: TextButton(
                      onPressed: () {
                        if (image != null) {
                          addPostBloc.add(
                            PreviewPostEvent(pickedPhoto: image, postDescription: postDescription.text),
                          );
                        }
                      },
                      child: Text(
                        'Next',
                        style: textStyles.textButtonText,
                      ),
                    )),
              ]),
              SizedBox(height: 20.h),
              SizedBox(
                height: 300.h,
                child: TextField(
                  controller: postDescription,
                  expands: false,
                  maxLines: null,
                  style: textStyles.elevatedButtonText,
                  decoration: const InputDecoration(
                    hintText: 'Enter text here...',
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  ),
                ),
              ),
            ]),
          ),
        );
      }
      if (state is LoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is PreviewPostState) {
        return PreviewPost(
          postDescription: state.postDescription!,
          image: state.image,
          addPostBloc: addPostBloc,
        );
      }
      if (state is SuccessfullUploadState) {
        return Material(
          child: Center(
            child: Column(
              children: [
                Text('Post successfull ulpoaded', style: textStyles.textStyle),
                SizedBox(height: 20.h),
                ElevatedButton(
                    onPressed: () {
                      addPostBloc.add(ResetEvent());
                    },
                    child: Text('back', style: textStyles.elevatedButtonText)),
              ],
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
