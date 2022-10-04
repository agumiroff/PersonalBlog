import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../core/presentation/widgets/avatar_widget.dart';
import '../../../../core/presentation/widgets/profile_button_widget.dart';
import '../../service_locator/service_locator.dart';
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
    BlocProvider.of<UserProfileBloc>(context).add(UserProfileDataCheck());
    print('initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    UserProfileBloc userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return BlocBuilder<UserProfileBloc, UserProfileStates>(builder: (context, state) {
      if (state is UserProfileMainState) {
        return Material(
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
                  locator<ServiceLocator>().navigationService.navigateTo('bookmarks');
                },
              ),
              SizedBox(height: 10.h),
              ProfileButtonWidget(
                icon: Icons.folder,
                text: 'My posts',
                onTap: () {
                  locator<ServiceLocator>().navigationService.navigateTo('posts');
                },
              ),
              SizedBox(height: 10.h),
              ProfileButtonWidget(
                icon: Icons.edit,
                text: 'Edit profile',
                onTap: () {
                  locator<ServiceLocator>().navigationService.navigateTo('edit_profile');
                },
              ),
              SizedBox(height: 209.h),
              GestureDetector(
                onTap: () {
                  userProfileBloc.add(LogOutEvent());
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
      return const Center(child: CircularProgressIndicator());
    });
  }
}
