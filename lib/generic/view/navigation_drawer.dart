import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';

import 'navigation_button.dart';

class AppNavigationDrawer extends StatelessWidget {
  final List<String> navigationItemTitles;
  final int currentNavigationItemIndex;
  final void Function(int index) onNavigationItemIndexPressed;

  const AppNavigationDrawer({
    super.key,
    required this.navigationItemTitles,
    required this.currentNavigationItemIndex,
    required this.onNavigationItemIndexPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colorScheme().surfaceContainerLowest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List<Widget>.from(
              navigationItemTitles.mapIndexed(
                (index, title) => NavigationButton(
                  title: title,
                  isCurrentItem: index == currentNavigationItemIndex,
                  layoutAxis: Axis.vertical,
                  onPressed: () => onNavigationItemIndexPressed(
                    index,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
