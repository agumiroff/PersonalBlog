import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/core/domain/entities/post_entity.dart';
import 'package:personal_blog/core/domain/repository/repository.dart';
import 'package:personal_blog/features/user_profile/domain/data_storage.dart';
import 'package:personal_blog/features/user_profile/domain/use_cases/create_user_data.dart';
import 'package:personal_blog/features/user_profile/domain/use_cases/create_list_of_posts.dart';
import 'package:personal_blog/features/user_profile/service_locator/service_locator.dart';

//================================States================================
abstract class UserProfileStates {}

class PreloadUserDataFailed extends UserProfileStates {}

class ShowPostFeedState extends UserProfileStates {
  List<PostData> listOfPosts;
  final String firstName;
  final String secondName;

  ShowPostFeedState({
    required this.firstName,
    required this.secondName,
    required this.listOfPosts,
  });
}

class UserProfileLoadingState extends UserProfileStates {}

class ShowBookmarksState extends UserProfileStates {}

class ShowMyPostsState extends UserProfileStates {
  List<PostData> listofData;
  ShowMyPostsState({required this.listofData});
}

class PreloadUserDataState extends UserProfileStates {}

class UserProfileMainState extends UserProfileStates {
  final String firstName;
  final String secondName;

  UserProfileMainState({required this.firstName, required this.secondName});
}

//================================Events================================
abstract class UserProfileEvents {}

class ShowPostFeedEvent extends UserProfileEvents {}

class UserProfileMainEvent extends UserProfileEvents {}

class UserProfileDataCheck extends UserProfileEvents {}

class PreloadUserDataFailedEvent extends UserProfileEvents {}

class LogOutEvent extends UserProfileEvents {}

class PreloadUserDataEvent extends UserProfileEvents {}

class ShowBookmarksEvent extends UserProfileEvents {}

class ShowMyPostsEvent extends UserProfileEvents {}

class UserProfileBloc extends Bloc<UserProfileEvents, UserProfileStates> {
  UserProfileBloc() : super(UserProfileLoadingState()) {
    on<UserProfileDataCheck>((event, emit) {
      if (dataStorage.userData != null) {
        add(UserProfileMainEvent());
        print('notNull');
      }
      if (dataStorage.userData == null) {
        add(PreloadUserDataEvent());
        print('null');
      }
    });
    on<PreloadUserDataEvent>((event, emit) async {
      if (repository.firebaseAuth.currentUser?.getIdToken() != null) {
        dataStorage.userData = await CreateUserData().createUserData();
        add(UserProfileMainEvent());
      } else {
        locator<ServiceLocator>().globalNavigationService.navigateTo('sign_in');
      }
    });
    on<UserProfileMainEvent>((event, emit) async {
      emit(UserProfileMainState(
        firstName: dataStorage.userData!.firstName,
        secondName: dataStorage.userData!.secondName,
      ));
    });
    on<ShowBookmarksEvent>((event, emit) {
      emit(UserProfileLoadingState());
      emit(ShowBookmarksState());
    });
    on<ShowMyPostsEvent>((event, emit) async {
      UserProfileLoadingState();
      if (dataStorage.postData == null) {
        DocumentSnapshot<Map<String, dynamic>> mapOfUsers =
            await repository.firestore.collection('users').doc(repository.firebaseAuth.currentUser!.uid).get();
        dataStorage.postData = mapOfUsers;
        print('null posts');
      } else {
        print('not null posts');
      }
      emit(ShowMyPostsState(listofData: await CreateListOfPosts().createListOfPosts(dataStorage.postData!)));
    });
    on<ShowPostFeedEvent>((event, emit) async {
      emit(ShowPostFeedState(
        firstName: dataStorage.userData!.firstName,
        secondName: dataStorage.userData!.secondName,
        listOfPosts: await CreateListOfPosts().createListOfPosts(dataStorage.postData!),
      ));
    });
    on<LogOutEvent>((event, emit) {
      repository.firebaseAuth.signOut();
      dataStorage.userData = null;
      locator<ServiceLocator>().globalNavigationService.navigateTo('sign_in');
    });
  }
}
