import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/core/presentation/pages/success_page.dart';
import 'package:personal_blog/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:personal_blog/features/add_post/presentation/pages/preview_post.dart';
import 'add_post_main_page.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController postDescription = TextEditingController();
    return BlocBuilder<AddPostBloc, AddPostStates>(builder: (context, state) {
      Widget screenPage = const SizedBox.shrink();
      var image;
      if (state is AddPostStartState) {
        state.image == null ? image = const AssetImage('assets/empty_photo.jpg') : image = MemoryImage(state.image!);
        screenPage = AddPostMainPage(postDescription: postDescription, image: image);
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
        screenPage = const SuccessPage();
      }
      return screenPage;
    });
  }
}
