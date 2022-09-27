import '../../../../core/domain/entities/user_entity.dart';

class EmptyFieldCheck {
  bool fieldsNotEmptyCheck(UserData user) {
    if (user.email.isNotEmpty && user.firstName.isNotEmpty && user.secondName.isNotEmpty && user.password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
