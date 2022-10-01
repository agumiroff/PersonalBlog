import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/core/presentation/pages/main_page.dart';
import 'package:personal_blog/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import '../../../features/sign_in/presentation/bloc/sign_in_bloc.dart';
import '../../../features/sign_in/presentation/pages/sign_in_page.dart';
import '../../../features/sign_up/presentation/bloc/sign_up_bloc.dart';
import '../../../features/sign_up/presentation/pages/sign_up_page.dart';
import '../pages/error_page.dart';

class Navigation {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => UserProfileBloc(),
                  child: const MainPage(),
                ));
      case 'sign_in':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SignInBloc(),
                  child: const SignInPage(),
                ));
      case 'sign_up':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SignUpBloc(),
                  child: const SignUpPage(),
                ));
      case 'error':
        return MaterialPageRoute(
            builder: (_) => ErrorScreen(
                  value: 'dxzcxz',
                  onPressed: () {},
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorScreen(
                  value: 'saddasdas',
                  onPressed: () {},
                ));
    }
  }
}
