import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/domain/repository/repository.dart';

addPostToDoc(String uuid) async {
  DocumentSnapshot<Map<String, dynamic>> tempMap =
      await repository.firestore.collection('users').doc(repository.firebaseAuth.currentUser!.uid).get();
  List<dynamic> tempList = tempMap['posts'];
  tempList.add(uuid);
  await repository.firestore
      .collection('users')
      .doc(repository.firebaseAuth.currentUser!.uid)
      .update({'posts': tempList});
}
