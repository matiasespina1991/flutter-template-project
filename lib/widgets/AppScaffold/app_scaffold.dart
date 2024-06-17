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
import '../ThemeAppBar/template_app_bar.dart';
import '../ThemeFloatingSpeedDialMenu/theme_floating_speed_dial_menu.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final bool hideFloatingSpeedDialMenu;
  final String appBarTitle;
  final bool protected;

  const AppScaffold({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.hideFloatingSpeedDialMenu = false,
    this.protected = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthorizationProvider, ThemeNotifier>(
      builder: (context, auth, theme, child) {
        if (Config.useProtectedRoutes && protected && !auth.isAuthenticated) {
          return Navigator(
            onGenerateRoute: (settings) {
              return createRoute(const LoginScreen());
            },
          );
        }

        bool isDarkMode = theme.themeMode == ThemeMode.dark;
        ValueNotifier<bool> isDialOpen = ValueNotifier(false);

        return Scaffold(
          appBar: Config.useTopAppBar
              ? ThemeAppBar(
                  title: appBarTitle,
                )
              : null,
          body: Stack(
            children: [
              body,
              if (!hideFloatingSpeedDialMenu && Config.useFloatingSpeedDialMenu)
                Positioned.fill(
                  child: ValueListenableBuilder(
                    valueListenable: isDialOpen,
                    builder: (context, value, child) {
                      return value
                          ? BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
                              child: Container(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ),
            ],
          ),
          floatingActionButton: ThemeFloatingSpeedDialMenu(
            hideFloatingSpeedDialMenu: hideFloatingSpeedDialMenu,
            isDialOpenNotifier: isDialOpen,
          ),
        );
      },
    );
  }
}
