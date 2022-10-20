//================================Events================================
import 'package:bloc/bloc.dart';
import '../../../../core/data/storage/data_storage.dart';
import '../../../../core/domain/entities/post_entity.dart';

abstract class MyPostsEvents {}

class ShowMyPostsEvent extends MyPostsEvents {}

//================================States================================
abstract class MyPostsStates {}

class ShowMyPostsState extends MyPostsStates {
  final List<PostData> listOfData;

  ShowMyPostsState({required this.listOfData});
}

class LoadingPosts extends MyPostsStates {}

class MyPostsBloc extends Bloc<MyPostsEvents, MyPostsStates> {
  MyPostsBloc() : super(ShowMyPostsState(listOfData: dataStorage.postData!));
}
