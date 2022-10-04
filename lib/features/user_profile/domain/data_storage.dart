import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_blog/core/domain/entities/user_entity.dart';

class DataStorage {
  UserData? userData;
  DocumentSnapshot<Map<String, dynamic>>? postData;
}

DataStorage dataStorage = DataStorage();
