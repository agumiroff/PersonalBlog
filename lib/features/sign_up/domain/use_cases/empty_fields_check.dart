import '../../../../core/domain/entities/user_entity.dart';

class EmptyFieldCheck {
  bool fieldsNotEmptyCheck(UserData user) {
    if (user.email.isNotEmpty && user.fullname.isNotEmpty && user.password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
