import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:personal_blog/core/domain/repository/repository.dart';
import 'package:uuid/uuid.dart';

class AddPostUseCase {
  addPost(String path, Uint8List file) async {
    Uuid uuid = const Uuid();
    final randomID = uuid.v1();
    final reference =
        repository.firebaseStorage.ref().child(path).child(repository.firebaseAuth.currentUser!.uid).child(randomID);
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = 'emptyUrl';
    await (taskSnapshot.ref.getDownloadURL()).then((value) => downloadUrl = value);
    return downloadUrl;
  }
}
