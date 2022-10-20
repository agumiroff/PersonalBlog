import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../widgets/botom_navigation_bar_item_list.dart';

class StartPage extends StatefulWidget {
  final Widget child;
  const StartPage({Key? key, required this.child}) : super(key: key);

  @override
  State<StartPage> createState() => _MainPageState();
}

class _MainPageState extends State<StartPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.child,
      bottomNavigationBar: SizedBox(
        height: 60.h,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          unselectedItemColor: Colors.black,
          selectedItemColor: const Color(0xFF01A8E9),
          enableFeedback: false,
          currentIndex: currentIndex,
          onTap: (index) {
            if (currentIndex == index) {
              return;
            }
            currentIndex = index;
            context.go(navigationBarItems[index].location);
            setState(() {});
          },
          items: navigationBarItems,
        ),
      ),
    );
  }
}
