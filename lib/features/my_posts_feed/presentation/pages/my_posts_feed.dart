import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/styles/styles.dart';
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
    return BlocBuilder<MyPostFeedBloc, MyPostFeedStates>(
      builder: (context, state) {
        if (state is MyPostFeedLoadingState) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is ShowMyPostFeedState) {
          return Material(
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            context.go('/my_posts');
                          },
                          child: Text('Cancel', style: textStyles.textButtonText)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${state.userData.firstName} ${state.userData.secondName}',
                            style: textStyles.textStyle,
                          ),
                        ),
                      ),
                      SizedBox(width: 60.w),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
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
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
