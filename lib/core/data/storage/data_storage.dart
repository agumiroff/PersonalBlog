import 'package:personal_blog/core/domain/entities/user_entity.dart';
import '../../domain/entities/post_entity.dart';

class DataStorage {
  UserData? userData;
  List<PostData>? postData;

}

DataStorage dataStorage = DataStorage();
