import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/widgets/app_bar_widget.dart';
import '../bloc/add_post_bloc.dart';
import '../widgets/next_text_button_widget.dart';
import '../widgets/post_description_widget.dart';

class AddPostMainPage extends StatelessWidget {
  var image;
  final TextEditingController postDescription;
  AddPostMainPage({Key? key, this.image, required this.postDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(actionButton: [
        NextTextButton(
          image: image,
          postDescription: postDescription,
        )
      ], leadingButton: null),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            SizedBox(
                height: 400.h,
                width: 375.w,
                child: Image(
                  fit: BoxFit.cover,
                  image: image,
                )),
            Positioned(
                right: 60.w,
                bottom: 90.h,
                child: IconButton(
                    onPressed: () {
                      BlocProvider.of<AddPostBloc>(context).add(PickPhotoEvent(postDescription: postDescription.text));
                    },
                    icon: const Icon(Icons.add_circle, size: 40))),
          ]),
          SizedBox(height: 20.h),
          SizedBox(height: 300.h, child: PostDescription(postDescription: postDescription)),
        ]),
      ),
    );
  }
}
