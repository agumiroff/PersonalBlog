import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_blog/core/domain/entities/user_entity.dart';
import '../../../../core/domain/entities/post_entity.dart';
import '../../../../core/domain/repository/repository.dart';

class GetListOfPosts {
  Future<List<PostData>> getListOfPosts(UserData userData) async {
    List<PostData> listOfPosts = [];
    for (var element in userData.posts!) {
      DocumentSnapshot<Map<String, dynamic>> mapOfPost =
          await repository.firestore.collection('posts').doc(element).get();
      PostData postData = PostData(
          imagePath: mapOfPost['imagePath'],
          postDescription: mapOfPost['postDescription'],
          dateTime: mapOfPost['dateTime'],
          userId: mapOfPost['userId']);
      listOfPosts.add(postData);
    }
    listOfPosts.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return listOfPosts;
  }
}
