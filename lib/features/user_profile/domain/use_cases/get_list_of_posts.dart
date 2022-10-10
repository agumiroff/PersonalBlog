import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/domain/entities/post_entity.dart';
import '../../../../core/domain/repository/repository.dart';

class GetListOfPosts {
  Future<List<PostData>> getListOfPosts(DocumentSnapshot<Map<String, dynamic>> mapOfUsers) async {
    List<PostData> listOfPosts = [];
    for (var element in mapOfUsers['posts']) {
      DocumentSnapshot<Map<String, dynamic>> mapOfPost =
          await repository.firestore.collection('posts').doc(element).get();
      PostData postData = PostData(
          imagePath: mapOfPost['imagePath'],
          postDescription: mapOfPost['postDescription'],
          dateTime: mapOfPost['dateTime'],
          userId: mapOfPost['userId']);
      listOfPosts.add(postData);
    }
    return listOfPosts;
  }
}
