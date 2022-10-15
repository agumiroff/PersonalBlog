import 'package:bloc/bloc.dart';
import 'package:personal_blog/core/domain/entities/user_entity.dart';
import '../../../../core/data/storage/data_storage.dart';
import '../../../../core/domain/entities/post_entity.dart';

abstract class MyPostFeedEvents {}

class ShowMyPostFeedEvent extends MyPostFeedEvents {}

abstract class MyPostFeedStates {}

class MyPostFeedLoadingState extends MyPostFeedStates {}

class ShowMyPostFeedState extends MyPostFeedStates {
  final UserData userData;
  final List<PostData> listOfPosts;

  ShowMyPostFeedState(this.listOfPosts, this.userData);
}

class MyPostFeedBloc extends Bloc<MyPostFeedEvents, MyPostFeedStates> {
  MyPostFeedBloc() : super(MyPostFeedLoadingState()) {
    on<ShowMyPostFeedEvent>((event, emit) {
      emit(ShowMyPostFeedState(dataStorage.postData!, dataStorage.userData!));
    });
  }
}
