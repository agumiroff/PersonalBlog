//================================Events================================
import 'package:bloc/bloc.dart';
import '../../../core/data/storage/data_storage.dart';
import '../../../core/domain/entities/post_entity.dart';

abstract class UserPostsEvents {}

class ShowMyPostsEvent extends UserPostsEvents {}

//================================States================================
abstract class UserPostsStates {}

class ShowMyPostsState extends UserPostsStates {
  final List<PostData> listOfData;

  ShowMyPostsState({required this.listOfData});
}

class LoadingPosts extends UserPostsStates {}

class UserPostsBloc extends Bloc<UserPostsEvents, UserPostsStates> {
  UserPostsBloc() : super(ShowMyPostsState(listOfData: dataStorage.postData!));
}
