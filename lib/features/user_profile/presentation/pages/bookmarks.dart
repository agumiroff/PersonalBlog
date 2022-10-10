import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../service_locator/service_locator.dart';

import '../bloc/user_profile_bloc.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(ShowBookmarksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileStates>(
      builder: (context, state) {
        if (state is ShowBookmarksState) {
          return Material(
            child: Column(
              children: [
                SafeArea(
                    child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                      onPressed: () {
                        BlocProvider.of<UserProfileBloc>(context).add(UserProfileMainEvent());
                        locator.navigationService.goback();
                      },
                      child: Text('Cancel', style: textStyles.textButtonText)),
                )),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 1,
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
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
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
