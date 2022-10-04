import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';
import 'package:personal_blog/features/user_profile/service_locator/service_locator.dart';
import '../bloc/user_profile_bloc.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({
    Key? key,
  }) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(ShowMyPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<UserProfileBloc, UserProfileStates>(builder: (context, state) {
        if (state is UserProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ShowMyPostsState) {
          return Center(
            child: Column(
              children: [
                SafeArea(
                    child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                      onPressed: () {
                       locator<ServiceLocator>().navigationService.goback();
                      },
                      child: Text('Cancel', style: textStyles.textButtonText)),
                )),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 1,
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    children: state.listofData
                        .map(
                          (post) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'feed');
                            },
                            child: Image.network(post.imagePath, fit: BoxFit.cover),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
