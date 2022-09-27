import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:personal_blog/core/domain/entities/user_entity.dart';
import 'package:personal_blog/features/sign_up/domain/use_cases/create_user.dart';
import 'package:personal_blog/features/sign_up/domain/use_cases/empty_fields_check.dart';

import '../../../../core/presentation/pages/error_page.dart';
import '../../../../core/presentation/pages/success_page.dart';

abstract class SignUpEvents {}

class SignUpCheckEvent extends SignUpEvents {
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController secondNameController;
  final TextEditingController passwordController;
  final BuildContext context;

  SignUpCheckEvent(this.context, this.firstNameController, this.secondNameController,
      {required this.emailController, required this.passwordController});
}

class SignUpErrorEvent extends SignUpEvents {}

class SignUpResetEvent extends SignUpEvents {}

abstract class SignUpStates {}

class SignUpStartState extends SignUpStates {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}

class SignUpLoadingState extends SignUpStates {}

class SignUpCheckState extends SignUpStates {}

class SignUpSuccessful extends SignUpStates {}

class SignUpErrorState extends SignUpStates {}

class SignUpBloc extends Bloc<SignUpEvents, SignUpStates> {
  SignUpBloc() : super(SignUpStartState()) {
    on<SignUpResetEvent>((event, emit) {
      emit(SignUpStartState());
    });
    on<SignUpCheckEvent>((event, emit) {
      CreateUserUseCase createUserUseCase = CreateUserUseCase();
      EmptyFieldCheck emptyFieldCheck = EmptyFieldCheck();
      if (emptyFieldCheck.fieldsNotEmptyCheck(UserData(
        email: event.emailController.text,
        password: event.passwordController.text,
        [],
        [],
        event.firstNameController.text,
        event.secondNameController.text,
      ))) {
        createUserUseCase.createUser(UserData(
          email: event.emailController.text,
          password: event.passwordController.text,
          [],
          [],
          event.firstNameController.text,
          event.secondNameController.text,
        ));
        Navigator.push(
            event.context,
            PageRouteBuilder(
                opaque: false,
                pageBuilder: ((context, animation, secondaryAnimation) =>
                    const SuccessPage(value: 'Вы успешно зарегистрированы'))));
      } else {
        Navigator.push(
            event.context,
            PageRouteBuilder(
                opaque: false,
                pageBuilder: ((context, animation, secondaryAnimation) => ErrorScreen(
                      value: 'Заполните все поля и повторите попытку',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ))));
      }
    });
  }
}
