import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_app/providers/authorization_provider.dart';
import 'package:template_app/screens/loading_screen/loading_screen.dart';
import '../../config.dart';
import '../../providers/theme_provider.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../utils/create_route.dart';
import '../ThemeAppBar/template_app_bar.dart';
import '../ThemeFloatingSpeedDialMenu/theme_floating_speed_dial_menu.dart';

class AppScaffold extends StatefulWidget {
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
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  bool _navigated = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthorizationProvider, ThemeProvider>(
      builder: (context, auth, theme, child) {
        if (!Config.debugMode &&
            Config.useProtectedRoutes &&
            widget.protected &&
            !auth.isAuthenticated &&
            !_navigated) {
          _navigated = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(createRoute(
                const LoginScreen(),
                direction: SlideDirection.left));
          });
        }

        if (!auth.isAuthenticated && widget.protected) {
          return LoadingScreen();
        }

        ValueNotifier<bool> isDialOpen = ValueNotifier(false);

        return SafeArea(
          top: Config.useSafeArea,
          child: Scaffold(
            appBar: Config.useTopAppBar
                ? ThemeAppBar(
                    title: widget.appBarTitle,
                  )
                : null,
            body: Stack(
              children: [
                widget.body,
                if (!widget.hideFloatingSpeedDialMenu &&
                    Config.useFloatingSpeedDialMenu)
                  Positioned.fill(
                    child: ValueListenableBuilder(
                      valueListenable: isDialOpen,
                      builder: (context, value, child) {
                        return value
                            ? BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                child: Container(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              )
                            : SizedBox.shrink();
                      },
                    ),
                  ),
              ],
            ),
            floatingActionButton: ThemeFloatingSpeedDialMenu(
              hideFloatingSpeedDialMenu: widget.hideFloatingSpeedDialMenu,
              isDialOpenNotifier: isDialOpen,
            ),
          ),
        );
      },
    );
  }
}
