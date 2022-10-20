import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:personal_blog/features/add_post/presentation/pages/preview_post.dart';
import 'package:personal_blog/features/add_post/presentation/pages/success_page.dart';
import 'pick_photo_page.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostStates>(builder: (context, state) {
      Widget screenPage = const SizedBox.shrink();
      if (state is AddPostStartState) {
        screenPage = PickPhotoPage();
      }
      if (state is LoadingState) {
        screenPage = const Center(child: CircularProgressIndicator());
      }
      if (state is PreviewPostState) {
        screenPage = PreviewPost(
          postDescription: state.postDescription!,
          image: state.image,
        );
      }
      if (state is SuccessfullUploadState) {
        screenPage = const SuccessfulUploadPage();
      }
      return screenPage;
    });
  }
}
