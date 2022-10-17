import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/features/user_search/presentation/bloc/user_search_bloc.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  @override
  void initState() {
    BlocProvider.of<UserSearchBloc>(context).add(LoadUserList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<UserSearchBloc, UserSearchStates>(
        builder: (context, state) {
          if (state is UserSearchStartState) {
            return const Center(
              child: Text('sdds'),
            );
          }
          if (state is ShowUserListState) {
            return GridView.count(
              crossAxisCount: 3,
              children: state.listOfUserData.map((e) => Text(e.firstName + e.secondName)).toList(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
