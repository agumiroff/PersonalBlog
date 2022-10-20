import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/user_entity.dart';
import 'repository.dart';

class GetUserData {
  Map<String, dynamic> tempMap = {};
  Future<UserData> getUserData(userId) async {
    DocumentSnapshot snapShot = await repository.firestore.collection('users').doc(userId).get();
    tempMap = snapShot.data() as Map<String, dynamic>;
    UserData userData = UserData(
        tempMap['posts'],
        tempMap['bookMarks'],
        tempMap['firstName'],
        tempMap['secondName'],
        email: tempMap['email'],
        password: tempMap['password'],
        userId,
        tempMap['avatar']); //
    return userData;
  }
}

GetUserData userProfileRepository = GetUserData();
