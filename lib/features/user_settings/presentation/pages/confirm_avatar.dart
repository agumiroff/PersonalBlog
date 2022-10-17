import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../bloc/user_settings_bloc.dart';

class ConfirmAvatarPage extends StatelessWidget {
  final Uint8List? avatar;
  const ConfirmAvatarPage({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<UserSettingsBloc>(context).add(UserProfileMainEvent());
                    },
                    child: Text(
                      'Cancel',
                      style: textStyles.textButtonText,
                    )),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      if (avatar != null) {
                        BlocProvider.of<UserSettingsBloc>(context).add(
                          UploadAvatarToGallery(avatar!, context),
                        );
                      }
                    },
                    child: Text(
                      'Confirm',
                      style: textStyles.textButtonText,
                    )),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 150.w,
                backgroundImage: MemoryImage(avatar!),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
