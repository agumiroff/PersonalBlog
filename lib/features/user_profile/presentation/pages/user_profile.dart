import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/features/sign_in/presentation/pages/sign_in_page.dart';
import 'package:personal_blog/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:personal_blog/features/user_profile/presentation/pages/bookmarks.dart';
import 'package:personal_blog/features/user_profile/presentation/pages/my_posts.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../core/presentation/widgets/avatar_widget.dart';
import '../../../../core/presentation/widgets/profile_button_widget.dart';
import '../../../sign_in/presentation/bloc/sign_in_bloc.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfileBloc userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 34.h, horizontal: 20.w),
        child: BlocBuilder<UserProfileBloc, UserProfileStates>(
          builder: (context, state) {
            if (state is ShowBookmarksState) {
              return BookMarks(userProfileBloc: userProfileBloc);
            }
            if (state is ShowMyPostsState) {
              return MyPosts(userProfileBloc: userProfileBloc, listOfWidget: state.listofData,);
            }
            if (state is UserProfileLoadingState) {
              userProfileBloc.add(LoadUserDataEvent(context: context));
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserProfileStartState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 45.h),
                    AvatarWidget(text: '${state.firstName[0]}${state.secondName[0]}'),
                    SizedBox(height: 10.h),
                    Text(
                      '${state.firstName} ${state.secondName}',
                      style: textStyles.headerText,
                    ),
                    SizedBox(height: 25.h),
                    ProfileButtonWidget(
                      icon: Icons.bookmark,
                      text: 'Bookmarks',
                      onTap: () {
                        userProfileBloc.add(ShowBookmarksEvent());
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileButtonWidget(
                      icon: Icons.folder,
                      text: 'My posts',
                      onTap: () {
                        userProfileBloc.add(ShowMyPostsEvent());
                      },
                    ),
                    SizedBox(height: 10.h),
                    ProfileButtonWidget(
                      icon: Icons.edit,
                      text: 'Edit profile',
                      onTap: () {},
                    ),
                    SizedBox(height: 209.h),
                    GestureDetector(
                      onTap: () {
                        userProfileBloc.add(LogOutEvent(context: context));
                      },
                      child: Text(
                        'Log Out',
                        style: textStyles.logOutText,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
