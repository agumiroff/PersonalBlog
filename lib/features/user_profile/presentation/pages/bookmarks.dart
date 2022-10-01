import 'package:flutter/material.dart';
import '../bloc/user_profile_bloc.dart';

class BookMarks extends StatelessWidget {
  final UserProfileBloc userProfileBloc;
  const BookMarks({Key? key, required this.userProfileBloc}) : super(key: key);

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
              children: const [
                DecoratedBox(decoration: BoxDecoration(color: Colors.green)),
                DecoratedBox(decoration: BoxDecoration(color: Colors.green)),
                DecoratedBox(decoration: BoxDecoration(color: Colors.green)),
                DecoratedBox(decoration: BoxDecoration(color: Colors.green)),
                DecoratedBox(decoration: BoxDecoration(color: Colors.green)),
                DecoratedBox(decoration: BoxDecoration(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
