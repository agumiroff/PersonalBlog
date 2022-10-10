import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/core/domain/entities/post_entity.dart';
import 'package:personal_blog/core/domain/repository/repository.dart';
import 'package:personal_blog/features/user_profile/domain/data_storage.dart';
import 'package:personal_blog/features/user_profile/domain/use_cases/create_user_data.dart';
import 'package:personal_blog/features/user_profile/domain/use_cases/get_list_of_posts.dart';
import 'package:personal_blog/features/user_profile/service_locator/service_locator.dart';
import '../../../../core/presentation/navigation/global_navigation.dart';

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

class PreloadUserDataFailedEvent extends UserProfileEvents {}

class LogOutEvent extends UserProfileEvents {}

class PreloadUserDataEvent extends UserProfileEvents {}

class ShowBookmarksEvent extends UserProfileEvents {}

class ShowMyPostsEvent extends UserProfileEvents {}

class UserProfileBloc extends Bloc<UserProfileEvents, UserProfileStates> {
  final GlobalNavigationService globalNavigationService;

  UserProfileBloc(this.globalNavigationService) : super(UserProfileLoadingState()) {
    on<PreloadUserDataEvent>((event, emit) async {
      emit(UserProfileLoadingState());
      if (repository.firebaseAuth.currentUser == null) {
        print('=====================================');
        locator.globalNavigationService.navigateTo('sign_in');
      } else {
        dataStorage.userData = await CreateUserData().createUserData();
        add(UserProfileMainEvent());
        if (dataStorage.postData == null) {
          DocumentSnapshot<Map<String, dynamic>> mapOfUsers =
              await repository.firestore.collection('users').doc(repository.firebaseAuth.currentUser!.uid).get();
          dataStorage.postData = await GetListOfPosts().getListOfPosts(mapOfUsers);
        }
      }
    });
    on<UserProfileMainEvent>((event, emit) async {
      emit(UserProfileLoadingState());
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
      emit(ShowMyPostsState(listofData: dataStorage.postData!));
    });
    on<ShowPostFeedEvent>((event, emit) {
      emit(UserProfileLoadingState());
      emit(ShowPostFeedState(
        firstName: dataStorage.userData!.firstName,
        secondName: dataStorage.userData!.secondName,
        listOfPosts: dataStorage.postData!,
      ));
    });
    on<LogOutEvent>((event, emit) {
      emit(UserProfileLoadingState());
      repository.firebaseAuth.signOut();
      dataStorage.userData = null;
      dataStorage.postData = null;
      locator.globalNavigationService.navigateTo('sign_in');
    });
  }
}
