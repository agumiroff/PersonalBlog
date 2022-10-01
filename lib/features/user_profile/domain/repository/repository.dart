import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/domain/repository/repository.dart';

class UserProfileRepository {
  Map<String, dynamic> tempMap = {};
  Future<Map<String, dynamic>> getUserData() async {
    final currentUserId = repository.firebaseAuth.currentUser!.uid;
    DocumentSnapshot snapShot = await repository.firestore.collection('users').doc(currentUserId).get();
    tempMap = snapShot.data() as Map<String, dynamic>;
    return tempMap;
  }
}

UserProfileRepository userProfileRepository = UserProfileRepository();