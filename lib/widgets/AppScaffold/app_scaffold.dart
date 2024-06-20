import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_app/providers/providers_all.dart';
import 'package:template_app/screens/loading_screen/loading_screen.dart';
import '../../config.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../utils/navigation/push_route_with_animation.dart';
import '../ThemeAppBar/template_app_bar.dart';
import '../ThemeFloatingSpeedDialMenu/theme_floating_speed_dial_menu.dart';

class AppScaffold extends ConsumerStatefulWidget {
  final Widget body;
  final bool hideFloatingSpeedDialMenu;
  final String appBarTitle;
  final bool isProtected;
  final ScrollPhysics? scrollPhysics;

  const AppScaffold({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.hideFloatingSpeedDialMenu = false,
    this.isProtected = true,
    this.scrollPhysics,
  });

  @override
  AppScaffoldState createState() => AppScaffoldState();
}

class AppScaffoldState extends ConsumerState<AppScaffold> {
  bool _navigated = false;

  ScrollPhysics getScrollPhysics() {
    switch (Config.defaultScrollPhysics) {
      case 'never':
        return const NeverScrollableScrollPhysics();
      case 'always':
        return const AlwaysScrollableScrollPhysics();
      case 'clamp':
      default:
        return const AlwaysScrollableScrollPhysics();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final theme = ref.watch(themeProvider);

    if (!Config.debugMode &&
        Config.useProtectedRoutes &&
        widget.isProtected &&
        !auth.isAuthenticated &&
        !_navigated) {
      _navigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(pushRouteWithAnimation(
            const LoginScreen(),
            direction: SlideDirection.left));
      });
    }

    if (!auth.isAuthenticated && widget.isProtected) {
      return LoadingScreen();
    }

    ValueNotifier<bool> isFloatingMenuOpen = ValueNotifier(false);

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
            SingleChildScrollView(
              physics: widget.scrollPhysics ?? getScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: widget.body,
                ),
              ),
            ),
            if (!widget.hideFloatingSpeedDialMenu &&
                Config.useFloatingSpeedDialMenu)
              Positioned.fill(
                child: ValueListenableBuilder(
                  valueListenable: isFloatingMenuOpen,
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
          isDialOpenNotifier: isFloatingMenuOpen,
        ),
      ),
    );
  }
}
