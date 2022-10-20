import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/domain/repository/repository.dart';
import 'package:personal_blog/core/presentation/widgets/empty_avatar_picture.dart';
import 'package:personal_blog/features/add_post/domain/use_cases/select_image.dart';
import '../../../../core/data/storage/data_storage.dart';
import '../../../add_post/domain/use_cases/add_post.dart';
import '../../../../core/domain/repository/get_user_data.dart';
import '../../../../core/domain/repository/get_list_of_posts.dart';

//================================States================================
abstract class UserSettingsStates {}

class ConfirmAvatarPick extends UserSettingsStates {
  final Uint8List? avatar;

  ConfirmAvatarPick({required this.avatar});
}

class PreloadUserDataFailed extends UserSettingsStates {}

class UserSettingsLoadingState extends UserSettingsStates {}

class PreloadUserDataState extends UserSettingsStates {}

class UserSettingsMainState extends UserSettingsStates {
  final String firstName;
  final String secondName;
  final String avatarLink;

  UserSettingsMainState({required this.avatarLink, required this.firstName, required this.secondName});
}

//================================Events================================
abstract class UserProfileEvents {}

class UploadAvatarToGallery extends UserProfileEvents {
  final Uint8List pickerAvatar;
  final BuildContext context;

  UploadAvatarToGallery(this.pickerAvatar, this.context);
}

class PickAvataFromGallery extends UserProfileEvents {}

class UserSettingsMainEvent extends UserProfileEvents {}

class PreloadUserDataFailedEvent extends UserProfileEvents {}

class LogOutEvent extends UserProfileEvents {
  final BuildContext context;

  LogOutEvent(this.context);
}

class PreloadUserDataEvent extends UserProfileEvents {
  final BuildContext context;

  PreloadUserDataEvent(this.context);
}

class UserSettingsBloc extends Bloc<UserProfileEvents, UserSettingsStates> {
  UserSettingsBloc() : super(UserSettingsLoadingState()) {
    on<PreloadUserDataEvent>((event, emit) async {
      emit(UserSettingsLoadingState());
      if (repository.firebaseAuth.currentUser == null) {
        print('=====================================');
        event.context.go('/sign_in');
      } else {
        dataStorage.userData = await userProfileRepository.getUserData(repository.firebaseAuth.currentUser!.uid);
        dataStorage.postData ??= await GetListOfPosts().getListOfPosts(dataStorage.userData!);
        add(UserSettingsMainEvent());
      }
    });
    on<UserSettingsMainEvent>((event, emit) async {
      emit(UserSettingsLoadingState());
      emit(UserSettingsMainState(
        firstName: dataStorage.userData!.firstName,
        secondName: dataStorage.userData!.secondName,
        avatarLink: dataStorage.userData!.avatarLink.isEmpty ? emptyAvatarLink : dataStorage.userData!.avatarLink,
      ));
    });

    on<LogOutEvent>((event, emit) async {
      emit(UserSettingsLoadingState());
      repository.firebaseAuth.signOut();
      dataStorage.userData = null;
      dataStorage.postData = null;
      event.context.go('/sign_in');
    });
    on<PickAvataFromGallery>((event, emit) async {
      var image = await SelectImage().pickImageFromGallery();
      if (image != null) {
        emit(ConfirmAvatarPick(
          avatar: image,
        ));
      }
    });
    on<UploadAvatarToGallery>((event, emit) async {
      emit(UserSettingsLoadingState());
      if (dataStorage.userData!.avatarLink != '') {
        await repository.firebaseStorage.refFromURL(dataStorage.userData!.avatarLink).delete();
      }
      final String photoUrl = await UploadImage().uploadImage('avatars', event.pickerAvatar);
      await repository.firestore.collection('users').doc(dataStorage.userData!.uid).update({'avatar': photoUrl});
      await repository.firestore.collection('avatars').doc(dataStorage.userData!.uid).set({
        'userId': dataStorage.userData!.uid,
        'avatar': photoUrl,
      });
      dataStorage.userData = await userProfileRepository.getUserData(repository.firebaseAuth.currentUser!.uid);
      dataStorage.postData ??= await GetListOfPosts().getListOfPosts(dataStorage.userData!);
      emit(UserSettingsMainState(
        firstName: dataStorage.userData!.firstName,
        secondName: dataStorage.userData!.secondName,
        avatarLink: dataStorage.userData!.avatarLink.isEmpty ? emptyAvatarLink : dataStorage.userData!.avatarLink,
      ));
    });
  }
}
