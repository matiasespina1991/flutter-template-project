import 'package:provider/provider.dart';
import 'package:template_app/widgets/AppBar/template_app_bar.dart';
import 'package:flutter/material.dart';

import '../../helpers/theme_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Home',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Light Mode/Dark Mode',
            ),
            const SizedBox(height: 10),
            Switch(
              value: isDark,
              onChanged: (value) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme(value);
              },
            ),
            // Consumer<ThemeNotifier>(
            //   builder: (context, themeNotifier, child) {
            //     return Switch(
            //       value: themeNotifier.themeMode == ThemeMode.dark,
            //       activeTrackColor: Theme.of(context).colorScheme.secondary,
            //       onChanged: (value) {
            //         themeNotifier.toggleTheme(value);
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
