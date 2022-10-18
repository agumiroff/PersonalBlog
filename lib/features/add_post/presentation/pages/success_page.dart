import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../bloc/add_post_bloc.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            Text('Post successfull ulpoaded', style: textStyles.textStyle),
            SizedBox(height: 20.h),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AddPostBloc>(context).add(ResetEvent());
                },
                child: Text('back', style: textStyles.elevatedButtonText)),
          ],
        ),
      ),
    );
  }
}
