import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:personal_blog/core/domain/entities/user_entity.dart';
import 'package:personal_blog/core/presentation/pages/error_page.dart';
import '../../domain/use_cases/sign_in.dart';
import 'package:go_router/go_router.dart';

//Events

abstract class SignInEvents {}

class ResetEvent extends SignInEvents {}

class SignInEvent extends SignInEvents {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final BuildContext context;

  SignInEvent({
    required this.emailController,
    required this.passwordController,
    required this.context,
  });
}

//States
abstract class SignInStates {}

class SignInStartState extends SignInStates {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}

class SignInErrorState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInSuccessfulState extends SignInStates {}

class SignInBloc extends Bloc<SignInEvents, SignInStates> {
  SignInBloc() : super(SignInStartState()) {
    on<ResetEvent>((event, emit) {
      emit(SignInStartState());
    });
    on<SignInEvent>((event, emit) async {
      LoginUser loginUser = LoginUser();
      if (await loginUser.loginUser(
          UserData(
            email: event.emailController.text,
            password: event.passwordController.text,
            [],
            [],
            '',
            '',
            '',
            '',
          ),
          event.context)) {
        event.context.go('/');
      } else {
        Navigator.of(event.context).push(
          PageRouteBuilder(
            opaque: false, // set to false
            pageBuilder: (_, __, ___) => const ErrorPage(),
          ),
        );
      }
    });
  }
}
