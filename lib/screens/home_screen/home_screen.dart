import 'dart:ui';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:template_app/widgets/AppBar/template_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:template_app/widgets/AppScaffold/app_scaffold.dart';

import '../../config.dart';
import '../../providers/theme_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool useAppBar = Config.useTopAppBar;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: 'Home Screen',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Light Mode/Dark Mode',
            ),
            const SizedBox(height: 10),
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              activeTrackColor: Theme.of(context).colorScheme.secondary,
              onChanged: (value) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
