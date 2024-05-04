import 'package:number_trivia_app/core/app/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _textController.dispose();
    super.dispose();
  }

  void goToBranch(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return SlidingClippedNavBar(
      barItems: [
        BarItem(title: 'Trivia', icon: CupertinoIcons.t_bubble),
        BarItem(title: 'History', icon: Icons.history)
      ],
      selectedIndex: widget.navigationShell.currentIndex,
      onButtonPressed: (value) {
        widget.navigationShell.goBranch(value);
      },
      activeColor: AppColors.white,
      backgroundColor: AppColors.lightPrimaryColor,
    );
  }
}
