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
      navigatorKey: locator.navigationService.navigatorKey,
      onGenerateRoute: navigation.onGenerateRoute,
      initialRoute: '/',
    );
  }
}
