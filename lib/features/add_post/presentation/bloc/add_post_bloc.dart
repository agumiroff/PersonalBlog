import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_blog/core/domain/entities/post_entity.dart';
import 'package:personal_blog/core/domain/repository/repository.dart';
import 'package:personal_blog/features/add_post/domain/use_cases/add_post.dart';
import 'package:uuid/uuid.dart';

import '../../../user_profile/domain/data_storage.dart';
import '../../domain/use_cases/add_post_id_to_userdoc.dart';

abstract class AddPostEvents {}

class ResetEvent extends AddPostEvents {}

class PickPhotoEvent extends AddPostEvents {
  final Uint8List pickedPhoto;
  final String postDescription;
  PickPhotoEvent({required this.postDescription, required this.pickedPhoto});
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
    on<ResetEvent>((event, emit) {
      emit(AddPostStartState(null, ''));
    });
    on<PickPhotoEvent>((event, emit) {
      emit(AddPostStartState(event.pickedPhoto, ''));
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
      AddPostUseCase addPostUseCase = AddPostUseCase();
      final String photoUrl = await addPostUseCase.addPost('posts', event.pickedPhoto);
      PostData postData = PostData(
          imagePath: photoUrl, postDescription: event.postDescription, dateTime: Timestamp.now(), userId: userId);
      repository.firestore.collection('posts').doc(uuid).set(postData.toJson());
      addPostToDoc(uuid);
      dataStorage.postData = null;
      emit(SuccessfullUploadState());
    });
  }
}
