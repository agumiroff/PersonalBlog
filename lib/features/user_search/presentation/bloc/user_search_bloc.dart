import 'package:bloc/bloc.dart';
import 'package:personal_blog/features/user_search/domain/use_cases/get_all_users.dart';

import '../../../../core/domain/entities/user_entity.dart';

abstract class UserSearchEvents {}

class LoadUserList extends UserSearchEvents {}

abstract class UserSearchStates {}

class UserSearchStartState extends UserSearchStates {}

class ShowUserListState extends UserSearchStates {
  List<UserData> listOfUserData;

  ShowUserListState(this.listOfUserData);
}

class UserSearchBloc extends Bloc<UserSearchEvents, UserSearchStates> {
  UserSearchBloc() : super(UserSearchStartState()) {
    on<LoadUserList>((event, emit) async {
      emit(ShowUserListState(await GetAllUsers().getAllUsers()));
    });
  }
}
