import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';
import 'package:personal_blog/core/presentation/widgets/app_bar_widget.dart';
import 'package:personal_blog/core/presentation/widgets/cancel_text_button_widget.dart';
import 'package:personal_blog/core/presentation/widgets/empty_avatar_picture.dart';

import '../bloc/user_profile_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(ShowUserProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F6),
      appBar: const AppBarWidget(
        leadingButton: CancelTextButton(),
        actionButton: null, titleText: 'Authors',
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileStates>(builder: (context, state) {
        if (state is ShowUserProfileState) {
          return Stack(children: [
            CustomScrollView(slivers: [
              SliverAppBar(
                leading: const SizedBox.shrink(),
                backgroundColor: const Color.fromRGBO(255, 255, 255, 0.4),
                toolbarHeight: 150.h,
                pinned: true,
              ),
              SliverGrid(
                  delegate: SliverChildListDelegate(state.listOfPostData
                      .map((post) => GestureDetector(
                          onTap: () {
                            context.goNamed('post_feed',
                                params: {
                                  'first_name': state.userData.firstName.toString(),
                                  'second_name': state.userData.secondName.toString(),
                                },
                                extra: state.listOfPostData);
                          },
                          child: Image.network(post.imagePath, fit: BoxFit.cover)))
                      .toList()),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  )),
            ]),
            UserProfileAppBar(
              postCount: state.userData.posts!.length,
              avatarImage: state.userData.avatarLink.isEmpty ? emptyAvatarLink : state.userData.avatarLink,
            ),
          ]);
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class UserProfileAppBar extends StatelessWidget {
  final String avatarImage;
  const UserProfileAppBar({
    Key? key,
    required this.postCount,
    required this.avatarImage,
  }) : super(key: key);

  final int postCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Row(
        children: [
          Expanded(
              child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50.r,
            backgroundImage: NetworkImage(avatarImage),
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Posts', style: textStyles.headerText),
              SizedBox(height: 10.h),
              Text('$postCount', style: textStyles.textStyle),
            ],
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Followers', style: textStyles.headerText),
              SizedBox(height: 10.h),
              Text('50', style: textStyles.textStyle),
            ],
          )),
        ],
      ),
    );
  }
}
