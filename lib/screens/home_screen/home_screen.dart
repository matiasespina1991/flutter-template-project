import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:template_app/widgets/AppScaffold/app_scaffold.dart';

import '../../config.dart';
import '../../generated/l10n.dart';
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
            Text(
              S.of(context).lightModeDarkMode,
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
