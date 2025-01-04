import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:doit_today/core/resources/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upgrader/upgrader.dart';

class LayoutView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const LayoutView({
    super.key,
    required this.navigationShell,
  });

  @override
  State<LayoutView> createState() => LayoutViewState();
}

class LayoutViewState extends State<LayoutView> {
  final List<IconData> _icons = [
    Icons.task_alt_rounded,
    Icons.event_note_outlined,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      cupertinoButtonTextStyle: MyStyles.textStyle(
        color: Colors.black,
        fontSize: 12,
      ),
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      upgrader: Upgrader(
        languageCode: 'en',
        messages: UpgraderMessages(code: 'en'),
        countryCode: "EG",
      ),
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: _icons,
          activeIndex: widget.navigationShell.currentIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.smoothEdge,
          leftCornerRadius: 16,
          rightCornerRadius: 16,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          onTap: (index) => _onTap(index),
        ),
      ),
    );
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}








