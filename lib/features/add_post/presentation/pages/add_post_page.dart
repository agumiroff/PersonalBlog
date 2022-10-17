import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';
import 'package:personal_blog/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:personal_blog/features/add_post/presentation/pages/preview_post.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController postDescription = TextEditingController();
    return BlocBuilder<AddPostBloc, AddPostStates>(builder: (context, state) {
      if (state is AddPostStartState) {
        var image;
        if (state.image != null) {
          image = MemoryImage(state.image!);
        } else {
          image = const AssetImage('assets/empty_photo.jpg');
        }
        return Material(
          child: SingleChildScrollView(
            child: Column(children: [
              SafeArea(
                  child: Row(children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    if (state.image != null) {
                      BlocProvider.of<AddPostBloc>(context).add(
                        PreviewPostEvent(pickedPhoto: state.image!, postDescription: postDescription.text),
                      );
                    }
                  },
                  child: Text(
                    'Next',
                    style: textStyles.textButtonText,
                  ),
                ),
              ])),
              Stack(children: [
                SizedBox(
                  height: 400.h,
                  width: 375.w,
                  child: Image(
                    fit: BoxFit.cover,
                    image: image,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<AddPostBloc>(context).add(PickPhotoEvent(
                        postDescription: postDescription.text,
                      ));
                    },
                    icon: const Icon(Icons.add_circle, size: 40),
                  ),
                ),
              ]),
              SizedBox(height: 20.h),
              SizedBox(
                height: 300.h,
                child: PostDescription(postDescription: postDescription),
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
                      BlocProvider.of<AddPostBloc>(context).add(ResetEvent());
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

class PostDescription extends StatelessWidget {
  const PostDescription({
    Key? key,
    required this.postDescription,
  }) : super(key: key);

  final TextEditingController postDescription;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
