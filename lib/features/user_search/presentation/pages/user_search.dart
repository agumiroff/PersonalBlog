import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/presentation/widgets/app_bar_widget.dart';
import 'package:personal_blog/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:personal_blog/features/user_search/presentation/bloc/user_search_bloc.dart';

import '../../../../core/presentation/widgets/empty_avatar_picture.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F6),
      appBar: const AppBarWidget(titleText: 'Authors'),
      body: Column(
        children: [
          BlocBuilder<UserSearchBloc, UserSearchStates>(
            builder: (context, state) {
              if (state is UserSearchStartState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ShowUserListState) {
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    padding: const EdgeInsets.all(6.0),
                    children: state.listOfUserData
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              context.go('/search/user_profile', extra: e);
                            },
                            child: SizedBox(
                              height: 100.h,
                              width: 100.w,
                              child:
                                  Image.network(e.avatarLink == '' ? emptyAvatarLink : e.avatarLink, fit: BoxFit.cover),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
