import '../../../../core/domain/entities/user_entity.dart';
import '../repository/repository.dart';

class CreateUserData {
 Future<UserData> createUserData() async {
    var tempMap = await userProfileRepository.getUserData();
    UserData userData = UserData(tempMap['posts'], tempMap['bookMarks'], tempMap['firstName'], tempMap['secondName'],
        email: tempMap['email'], password: tempMap['password']); //
   return userData;
  }
}
