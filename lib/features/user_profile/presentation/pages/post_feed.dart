import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../core/presentation/widgets/post_view.dart';
import '../../service_locator/service_locator.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({Key? key}) : super(key: key);

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(ShowPostFeedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileStates>(
      builder: (context, state) {
        if (state is ShowPostFeedState) {
          return Material(
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<UserProfileBloc>(context).add(ShowMyPostsEvent());
                            locator.navigationService.goback();
                          },
                          child: Text('Cancel', style: textStyles.textButtonText)),
                      Text(
                        '${state.firstName} ${state.secondName}',
                        style: textStyles.textStyle,
                      ),
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
