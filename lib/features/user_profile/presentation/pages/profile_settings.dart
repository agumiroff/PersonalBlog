import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import '../../service_locator/service_locator.dart';
import '../navigation/routes.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context, listen: false).add(PreloadUserDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProfileNavigation navigation = UserProfileNavigation();
    return MaterialApp(
      navigatorKey: locator<ServiceLocator>().navigationService.navigatorKey,
      onGenerateRoute: navigation.onGenerateRoute,
      initialRoute: '/',

      // child: BlocBuilder<UserProfileBloc, UserProfileStates>(
      //   builder: (context, state) {
      //     if (state is UserProfileMainState) {
      //       return UserProfilePage(
      //         userProfileBloc: userProfileBloc,
      //         firstName: state.firstName,
      //         secondName: state.secondName,
      //       );
      //     }
      //     if (state is PreloadUserDataFailed) {
      //       Navigator.pushNamed(context, 'sign_in');
      //     }
      //     if (state is ShowPostFeedState) {
      //       return PostFeed(postData: state.listOfPosts);
      //     }
      //     if (state is ShowBookmarksState) {
      //       return BookMarks(userProfileBloc: userProfileBloc);
      //     }
      //     if (state is ShowMyPostsState) {
      //       return MyPosts(
      //         userProfileBloc: userProfileBloc,
      //         postData: state.listofData,
      //       );
      //     }
      //     if (state is UserProfileLoadingState) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //
      //     return const SizedBox.shrink();
      //   },
      // ),
    );
  }
}
