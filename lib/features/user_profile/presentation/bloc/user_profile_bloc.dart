import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/core/domain/entities/post_entity.dart';
import 'package:personal_blog/core/domain/entities/user_entity.dart';
import 'package:personal_blog/core/domain/repository/repository.dart';
import '../../domain/repository/repository.dart';

//================================States================================
abstract class UserProfileStates {}

class UserProfileLoadingState extends UserProfileStates {}

class ShowBookmarksState extends UserProfileStates {}

class ShowMyPostsState extends UserProfileStates {
  List<Widget> listofData;
  ShowMyPostsState({required this.listofData});
}

class UserProfileStartState extends UserProfileStates {
  final String firstName;
  final String secondName;

  UserProfileStartState({required this.firstName, required this.secondName});
}

//================================Events================================
abstract class UserProfileEvents {}

class UserProfileDataEvent extends UserProfileEvents {}

class LogOutEvent extends UserProfileEvents {
  BuildContext context;

  LogOutEvent({required this.context});
}

class LoadUserDataEvent extends UserProfileEvents {
  BuildContext context;

  LoadUserDataEvent({required this.context});
}

class ShowBookmarksEvent extends UserProfileEvents {}

class ShowMyPostsEvent extends UserProfileEvents {}

class UserProfileBloc extends Bloc<UserProfileEvents, UserProfileStates> {
  UserProfileBloc() : super(UserProfileLoadingState()) {
    late UserData userData;
    on<LoadUserDataEvent>((event, emit) async {
      if (repository.firebaseAuth.currentUser?.getIdToken() != null) {
        var tempMap = await userProfileRepository.getUserData();
        userData = UserData(tempMap['posts'], tempMap['bookMarks'], tempMap['firstName'], tempMap['secondName'],
            email: tempMap['email'], password: tempMap['password']);
        emit(UserProfileStartState(
          firstName: userData.firstName,
          secondName: userData.secondName,
        ));
      } else {
        Navigator.pushNamed(event.context, 'sign_in');
      }
    });
    on<UserProfileDataEvent>((event, emit) async {
      emit(UserProfileStartState(
        firstName: userData.firstName,
        secondName: userData.secondName,
      ));
    });
    on<ShowBookmarksEvent>((event, emit) {
      emit(ShowBookmarksState());
    });
    on<ShowMyPostsEvent>((event, emit) async {
      DocumentSnapshot<Map<String, dynamic>> mapOfUsers =
          await repository.firestore.collection('users').doc(repository.firebaseAuth.currentUser!.uid).get();
      List<Widget> listOfPosts = [];
      for (var element in mapOfUsers['posts']) {
        DocumentSnapshot<Map<String, dynamic>> mapOfPosts =
            await repository.firestore.collection('posts').doc(element).get();
        PostData postData = PostData(
            imagePath: mapOfPosts['imagePath'],
            postDescription: mapOfPosts['postDescription'],
            dateTime: mapOfPosts['dateTime'],
            userId: mapOfPosts['userId']);
        listOfPosts.add(
          GestureDetector(
            onTap: () {},
            child: Image.network(postData.imagePath, fit: BoxFit.fill),
          ),
        );
      }

      emit(ShowMyPostsState(listofData: listOfPosts));
    });
    on<LogOutEvent>((event, emit) {
      repository.firebaseAuth.signOut();
      Navigator.pushNamed(event.context, 'sign_in');
    });
  }
}

Future<UserData> getUserData(UserData userData) async {
  var tempData = await userProfileRepository.getUserData();
  return userData = UserData(tempData['posts'], tempData['bookMarks'], tempData['firstName'], tempData['secondName'],
      email: tempData['email'], password: tempData['password']);
}
