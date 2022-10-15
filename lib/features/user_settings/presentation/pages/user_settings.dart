import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../core/presentation/widgets/avatar_widget.dart';
import '../../../../core/presentation/widgets/profile_button_widget.dart';
import '../bloc/user_settings_bloc.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  void initState() {
    BlocProvider.of<UserSettingsBloc>(context).add(PreloadUserDataEvent(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<UserSettingsBloc, UserProfileStates>(builder: (context, state) {
        if (state is UserProfileLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
                    context.go('/bookmarks');
                  },
                ),
                SizedBox(height: 10.h),
                ProfileButtonWidget(
                  icon: Icons.folder,
                  text: 'My posts',
                  onTap: () {
                    context.go('/my_posts');
                  },
                ),
                SizedBox(height: 10.h),
                ProfileButtonWidget(
                  icon: Icons.edit,
                  text: 'Edit profile',
                  onTap: () {
                    context.go('/edit_profile');
                  },
                ),
                SizedBox(height: 209.h),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<UserSettingsBloc>(context).add(LogOutEvent(context));
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
      }),
    );
  }
}
