import 'package:flutter/material.dart';
import 'package:personal_blog/features/add_post/presentation/bloc/add_post_bloc.dart';
import '../bloc/user_profile_bloc.dart';

class MyPosts extends StatelessWidget {
  final UserProfileBloc userProfileBloc;
  final List<Widget> listOfWidget;
  const MyPosts({Key? key, required this.userProfileBloc, required this.listOfWidget,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                userProfileBloc.add(UserProfileDataEvent());
              },
              child: const Text('back')),
          Expanded(
            child: GridView.count(
              mainAxisSpacing: 3,
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              children:  listOfWidget,
            ),
          ),
        ],
      ),
    );
  }
}
