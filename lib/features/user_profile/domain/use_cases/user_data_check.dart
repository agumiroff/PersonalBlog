import 'package:personal_blog/core/domain/entities/user_entity.dart';

import '../repository/repository.dart';

class UserDataCheck {
  Future<UserData> dataCheck() async {
    var tempMap = await userProfileRepository.getUserData();
    UserData userData = UserData(tempMap['posts'], tempMap['bookMarks'], tempMap['firstName'], tempMap['secondName'],
        email: tempMap['email'], password: tempMap['password']);
    return userData;
  }
}
