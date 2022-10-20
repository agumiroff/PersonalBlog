import 'package:bloc/bloc.dart';
import 'package:personal_blog/core/domain/entities/user_entity.dart';
import 'package:personal_blog/core/domain/repository/get_list_of_posts.dart';

import '../../../../core/domain/entities/post_entity.dart';

abstract class UserProfileEvents {}

class ShowUserProfile extends UserProfileEvents {}

abstract class UserProfileStates {}

class UserProfileStartState extends UserProfileStates {}

class ShowUserProfileState extends UserProfileStates {
  final UserData userData;
  final List<PostData> listOfPostData;
  ShowUserProfileState(this.userData, this.listOfPostData);
}

class UserProfileBloc extends Bloc<UserProfileEvents, UserProfileStates> {
  final userData;
  UserProfileBloc({required this.userData}) : super(UserProfileStartState()) {
    on<ShowUserProfile>((event, emit) async {
      final List<PostData> listOfPostData = await GetListOfPosts().getListOfPosts(userData);
      emit(ShowUserProfileState(userData, listOfPostData));
    });
  }
}
