import 'package:flutter/material.dart';

class TemplateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TemplateAppBar({super.key, this.appBarHeight, this.title});

  final double? appBarHeight;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title ?? ''),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? kToolbarHeight);
}
