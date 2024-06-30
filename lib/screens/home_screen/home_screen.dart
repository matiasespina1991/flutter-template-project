import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_app/app_settings/app_general_settings.dart';
import 'package:template_app/widgets/AppScaffold/app_scaffold.dart';

import '../../generated/l10n.dart';
import '../../providers/providers_all.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool useAppBar = AppGeneralSettings.useTopAppBar;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: 'Home Screen',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).lightMode,
                  style: TextStyle(
                    fontWeight: Theme.of(context).brightness == Brightness.light
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                const Text(
                  ' / ',
                ),
                Text(
                  S.of(context).darkMode,
                  style: TextStyle(
                    fontWeight: Theme.of(context).brightness == Brightness.dark
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              activeTrackColor: Theme.of(context).colorScheme.secondary,
              onChanged: (value) {
                ref.read(themeProvider).toggleTheme(value);
              },
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     try {
            //       throw Exception("Test exception for ErrorReportingService");
            //     } catch (error, stackTrace) {
            //       ErrorReportingService.reportError(
            //         error,
            //         stackTrace,
            //         CurrentUserData(userId: 'demoid', isAnonymous: true),
            //       );
            //     }
            //   },
            //   child: const Text("Trigger Error"),
            // ),
          ],
        ),
      ),
    );
  }
}
