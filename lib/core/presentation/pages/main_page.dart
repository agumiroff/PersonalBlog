import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:personal_blog/features/add_post/presentation/pages/add_post_page.dart';
import 'package:personal_blog/features/home/presentation/pages/home_page.dart';
import 'package:personal_blog/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:personal_blog/features/user_profile/presentation/pages/profile_settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screens = [
      const HomePage(),
      BlocProvider(
        create: (context) => AddPostBloc(),
        child: const AddPostPage(),
      ),
      BlocProvider(
        create: (context) => UserProfileBloc(),
        child: const ProfileSettings(),
      ),
    ];
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            label: 'Add post',
            icon: Icon(Icons.add_box_outlined),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.settings),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
