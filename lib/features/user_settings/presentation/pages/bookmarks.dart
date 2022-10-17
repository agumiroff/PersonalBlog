import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../bloc/user_settings_bloc.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsBloc, UserProfileStates>(
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
                        BlocProvider.of<UserSettingsBloc>(context).add(UserProfileMainEvent());
                        context.pop();
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
