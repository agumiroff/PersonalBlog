import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/features/my_authors/presentation/bloc/my_authors_bloc.dart';
import '../../../../core/presentation/widgets/app_bar_widget.dart';

class MyAuthorsPage extends StatelessWidget {
  const MyAuthorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(actionButton: null),
      body: BlocBuilder<MyAuthorsBloc, MyAuthorsStates>(
        builder: (context, state) {
          if (state is MyAuthorsStartState) {
            return const Text('ssdss');
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


