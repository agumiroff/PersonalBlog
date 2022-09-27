import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/profile_button_widget.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(
                    color: const Color(0xFFF2F2F2),
                    width: 4,
                  )),
              width: 150,
              height: 150,
              padding: const EdgeInsets.all(8),
              child: const CircleAvatar(radius: 100, backgroundColor: Colors.blue, child: Text('FD')),
            ),
            const SizedBox(height: 20),
            const Text(
              'Flutter Dev',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Noah',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.02),
            ),
            const Spacer(),
            const SizedBox(
              width: 335,
              height: 60,
              child: ProfileButtonWidget(
                icon: Icons.bookmark,
                text: 'Bookmarks',
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 335,
              height: 60,
              child: ProfileButtonWidget(
                icon: Icons.folder,
                text: 'My posts',
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 335,
              height: 60,
              child: ProfileButtonWidget(
                icon: Icons.edit,
                text: 'Edit profile',
              ),
            ),
            const Spacer(flex: 6),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Log Out',
                style: TextStyle(
                    color: Color(0xFFDD553D),
                    fontFamily: 'Noah',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
