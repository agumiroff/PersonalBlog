import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:personal_blog/core/domain/entities/post_entity.dart';
import 'package:personal_blog/core/domain/repository/repository.dart';
import 'package:personal_blog/features/add_post/domain/use_cases/add_post.dart';
import 'package:personal_blog/features/add_post/domain/use_cases/select_image.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/data/storage/data_storage.dart';
import '../../domain/use_cases/add_post_id_to_userdoc.dart';

abstract class AddPostEvents {}

class PreloadData extends AddPostEvents {}

class ResetEvent extends AddPostEvents {}

class PickPhotoEvent extends AddPostEvents {
  final String postDescription;
  PickPhotoEvent({required this.postDescription});
}

class AddPostEvent extends AddPostEvents {
  final Uint8List pickedPhoto;
  final String postDescription;

  AddPostEvent({required this.pickedPhoto, required this.postDescription});
}

class PreviewPostEvent extends AddPostEvents {
  final Uint8List pickedPhoto;
  final String postDescription;

  PreviewPostEvent({required this.pickedPhoto, required this.postDescription});
}

/*




 */

abstract class AddPostStates {}

class LoadingState extends AddPostStates {}

class AddPostStartState extends AddPostStates {
  final Uint8List? image;
  final String? postDescription;

  AddPostStartState(this.image, this.postDescription);
}

class PreviewPostState extends AddPostStates {
  final Uint8List image;
  final String? postDescription;

  PreviewPostState({required this.postDescription, required this.image});
}

class SuccessfullUploadState extends AddPostStates {}

class AddPostBloc extends Bloc<AddPostEvents, AddPostStates> {
  AddPostBloc() : super(AddPostStartState(null, '')) {
    var image;
    on<PickPhotoEvent>((event, emit) async {
      if (image != null) {
        emit(AddPostStartState(image, ''));
      } else {
        image = await SelectImage().pickImageFromGallery();
        emit(AddPostStartState(image, ''));
      }
    });
    on<ResetEvent>((event, emit) {
      emit(AddPostStartState(null, ''));
    });
    on<PreviewPostEvent>((event, emit) {
      if (event.pickedPhoto.isNotEmpty) {
        emit(
          PreviewPostState(image: event.pickedPhoto, postDescription: event.postDescription),
        );
      } else {
        emit(AddPostStartState(null, event.postDescription));
      }
    });
    on<AddPostEvent>((event, emit) async {
      emit(LoadingState());
      final userId = repository.firebaseAuth.currentUser!.uid;
      final uuid = const Uuid().v1();
      final String photoUrl = await UploadImage().uploadImage('posts', event.pickedPhoto);
      PostData postData = PostData(
        imagePath: photoUrl,
        postDescription: event.postDescription,
        dateTime: Timestamp.now(),
        userId: userId,
      );
      repository.firestore.collection('posts').doc(uuid).set(postData.toJson());
      addPostToDoc(uuid);
      dataStorage.postData = null;
      emit(SuccessfullUploadState());
    });
  }
}
