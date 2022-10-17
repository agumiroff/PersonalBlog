import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/domain/repository/repository.dart';

class UserProfileRepository {
  Map<String, dynamic> tempMap = {};
  Future<UserData> getUserData() async {
    final currentUserId = repository.firebaseAuth.currentUser!.uid;
    DocumentSnapshot snapShot = await repository.firestore.collection('users').doc(currentUserId).get();
    tempMap = snapShot.data() as Map<String, dynamic>;
    UserData userData = UserData(
        tempMap['posts'],
        tempMap['bookMarks'],
        tempMap['firstName'],
        tempMap['secondName'],
        email: tempMap['email'],
        password: tempMap['password'],
        currentUserId, tempMap['avatar']); //
    return userData;
  }
}

UserProfileRepository userProfileRepository = UserProfileRepository();
