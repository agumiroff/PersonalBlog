import 'package:cloud_firestore/cloud_firestore.dart';

class PostData {
  final String imagePath;
  final String postDescription;
  final Timestamp dateTime;
  final String userId;

  PostData({required this.imagePath, required this.postDescription, required this.dateTime, required this.userId});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'postDescription': postDescription,
      'dateTime': dateTime,
      'userId': userId,
    };
  }
}
