import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/domain/repository/repository.dart';
import '../../../../core/presentation/pages/error_page.dart';

class LoginUser {
  Future<bool> loginUser(UserData userData, BuildContext context) async {
    if (userData.email.isNotEmpty && userData.password.isNotEmpty) {
      try {
        await repository.firebaseAuth.signInWithEmailAndPassword(email: userData.email, password: userData.password);
        return true;
      } on FirebaseAuthException {
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                pageBuilder: ((context, _, __) => ErrorScreen(
                      value: 'Неверный логин или пароль',
                      onPressed: () {
                        Navigator.pushNamed(context, 'sign_in');
                      },
                    ))));
        return false;
      }
    } else {
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: ((context, _, __) => ErrorScreen(
                    value: 'Заполните все поля и повторите попытку',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))));
      return false;
    }
  }
}
