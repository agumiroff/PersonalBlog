import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../bloc/user_settings_bloc.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<UserSettingsBloc>(context).add(LogOutEvent(context));
      },
      child: Text(
        'Log Out',
        style: textStyles.logOutText,
      ),
    );
  }
}
