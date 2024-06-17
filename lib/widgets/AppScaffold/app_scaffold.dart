import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:template_app/providers/authorization_provider.dart';
import '../../config.dart';
import '../../generated/l10n.dart';
import '../../providers/theme_notifier.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../utils/create_route.dart';
import '../TemplateAppBar/template_app_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final bool hideSpeedDial;
  final String appBarTitle;
  final bool protected;

  const AppScaffold({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.hideSpeedDial = false,
    this.protected = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorizationProvider>(
      builder: (context, auth, child) {
        if (Config.useProtectedRoutes && protected && !auth.isAuthenticated) {
          return Navigator(
            onGenerateRoute: (settings) {
              return createRoute(const LoginScreen());
            },
          );
        }

        ValueNotifier<bool> isDialOpen = ValueNotifier(false);
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          appBar: Config.useTopAppBar
              ? TemplateAppBar(
                  title: appBarTitle,
                )
              : null,
          body: Stack(
            children: [
              body,
              if (!hideSpeedDial && Config.useSpeedDial)
                ValueListenableBuilder(
                  valueListenable: isDialOpen,
                  builder: (context, value, child) {
                    return value
                        ? BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
                            child: Container(
                              color: Colors.black.withOpacity(0),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                ),
            ],
          ),
          floatingActionButton: SpeedDial(
            animationDuration: const Duration(milliseconds: 200),
            elevation: 1.5,
            spacing: 10.0,
            visible: hideSpeedDial | !Config.useSpeedDial ? false : true,
            icon: Icons.add,
            activeIcon: Icons.close,
            iconTheme: const IconThemeData(color: Colors.white),
            activeBackgroundColor: Theme.of(context).colorScheme.secondary,
            activeForegroundColor: Colors.white,
            curve: Curves.easeInOut,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.settings),
                label: S.of(context).settingsButton,
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  // Add your action here
                },
              ),
              SpeedDialChild(
                child: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Icon(
                    isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                  ),
                ),
                label: isDarkMode
                    ? S.of(context).lightMode
                    : S.of(context).darkMode,
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .toggleTheme(isDarkMode ? false : true);
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.logout),
                label: S.of(context).logoutButton,
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Provider.of<AuthorizationProvider>(context, listen: false)
                      .signOut(context);
                },
              ),
            ],
            onOpen: () {
              isDialOpen.value = true;
            },
            onClose: () {
              isDialOpen.value = false;
            },
          ),
        );
      },
    );
  }
}
