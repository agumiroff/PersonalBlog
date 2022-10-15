import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/domain/repository/repository.dart';
import '../../../../core/data/storage/data_storage.dart';
import '../../domain/repository/repository.dart';
import '../../domain/use_cases/get_list_of_posts.dart';

//================================States================================
abstract class UserProfileStates {}

class PreloadUserDataFailed extends UserProfileStates {}

class UserProfileLoadingState extends UserProfileStates {}

class ShowBookmarksState extends UserProfileStates {}

class PreloadUserDataState extends UserProfileStates {}

class UserProfileMainState extends UserProfileStates {
  final String firstName;
  final String secondName;

  UserProfileMainState({required this.firstName, required this.secondName});
}

//================================Events================================
abstract class UserProfileEvents {}

class UserProfileMainEvent extends UserProfileEvents {}

class PreloadUserDataFailedEvent extends UserProfileEvents {}

class LogOutEvent extends UserProfileEvents {
  BuildContext context;

  LogOutEvent(this.context);
}

class PreloadUserDataEvent extends UserProfileEvents {
  BuildContext context;

  PreloadUserDataEvent(this.context);
}

class ShowBookmarksEvent extends UserProfileEvents {}

class UserSettingsBloc extends Bloc<UserProfileEvents, UserProfileStates> {
  UserSettingsBloc() : super(UserProfileLoadingState()) {
    on<PreloadUserDataEvent>((event, emit) async {
      emit(UserProfileLoadingState());
      if (repository.firebaseAuth.currentUser == null) {
        print('=====================================');
        event.context.go('/sign_in');
      } else {
        dataStorage.userData = await userProfileRepository.getUserData();
        dataStorage.postData ??= await GetListOfPosts().getListOfPosts(dataStorage.userData!);
        add(UserProfileMainEvent());
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
    on<LogOutEvent>((event, emit) async {
      emit(UserProfileLoadingState());
      repository.firebaseAuth.signOut();
      dataStorage.userData = null;
      dataStorage.postData = null;
      event.context.go('/sign_in');
    });
  }
}
