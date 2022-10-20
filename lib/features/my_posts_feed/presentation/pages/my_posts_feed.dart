import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/widgets/cancel_text_button_widget.dart';
import '../../../../core/presentation/widgets/app_bar_widget.dart';
import '../../../../core/presentation/widgets/post_view.dart';
import '../bloc/my_post_feed_bloc.dart';

class MyPostFeed extends StatefulWidget {
  const MyPostFeed({Key? key}) : super(key: key);

  @override
  State<MyPostFeed> createState() => _MyPostFeedState();
}

class _MyPostFeedState extends State<MyPostFeed> {
  @override
  void initState() {
    BlocProvider.of<MyPostFeedBloc>(context).add(ShowMyPostFeedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2F2F6),
        appBar: const AppBarWidget(
          actionButton: null,
          leadingButton: CancelTextButton(),
          titleText: 'My posts',
        ),
        body: BlocBuilder<MyPostFeedBloc, MyPostFeedStates>(
          builder: (context, state) {
            if (state is MyPostFeedLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ShowMyPostFeedState) {
              return Column(
                children: [
                  SizedBox(width: 60.w),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(4.0.w),
                      dragStartBehavior: DragStartBehavior.values.last,
                      children: state.listOfPosts
                          .map((postData) => PostView(
                                postImage: postData.imagePath,
                                postDescription: postData.postDescription,
                                dateTime: postData.dateTime,
                                firstName: state.userData.firstName,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
