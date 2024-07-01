import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:template_app/app_settings/app_general_settings.dart';
import 'package:template_app/app_settings/auth_config.dart';
import 'package:template_app/providers/providers_all.dart';
import 'package:template_app/screens/loading_screen/loading_screen.dart';
import '../../app_settings/theme_settings.dart';

import '../../screens/login_screen/login_screen.dart';
import '../../utils/navigation/push_route_with_animation.dart';
import '../../utils/ui/is_dark_mode.dart';
import '../ThemeAppBar/template_app_bar.dart';
import '../ThemeFloatingSpeedDialMenu/theme_floating_speed_dial_menu.dart';

class AppScaffold extends ConsumerStatefulWidget {
  final Widget body;
  final bool hideFloatingSpeedDialMenu;
  final String appBarTitle;
  final bool isProtected;
  final ScrollPhysics? scrollPhysics;
  final bool addSafeAreaMargin;

  const AppScaffold({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.hideFloatingSpeedDialMenu = false,
    this.isProtected = true,
    this.scrollPhysics,
    this.addSafeAreaMargin = false,
  });

  @override
  AppScaffoldState createState() => AppScaffoldState();
}

class AppScaffoldState extends ConsumerState<AppScaffold> {
  bool _navigated = false;

  ScrollPhysics getScrollPhysics() {
    switch (ThemeSettings.defaultScrollPhysics) {
      case 'never':
        return const NeverScrollableScrollPhysics();
      case 'always':
        return const AlwaysScrollableScrollPhysics();
      case 'clamp':
        return const ClampingScrollPhysics();
      default:
        return const AlwaysScrollableScrollPhysics();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    if (!DebugConfig.debugMode &&
        AuthConfig.useProtectedRoutes &&
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
      return const LoadingScreen();
    }

    ValueNotifier<bool> isFloatingMenuOpen = ValueNotifier(false);

    final animationConfig = isDarkMode(context)
        ? ThemeSettings.loginScreenLottieBackgroundAnimationDarkMode
        : ThemeSettings.loginScreenLottieBackgroundAnimationLightMode;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: AppGeneralSettings.useTopAppBar,
      child: Scaffold(
        appBar: AppGeneralSettings.useTopAppBar
            ? ThemeAppBar(
                title: widget.appBarTitle,
              )
            : null,
        body: Stack(
          children: [
            // Lottie Animation as background
            if (animationConfig.active)
              Positioned(
                left: (screenWidth / 2) +
                    animationConfig.x -
                    (screenWidth * (animationConfig.width / 100) / 2),
                top: (screenHeight / 2) +
                    animationConfig.y -
                    (screenWidth * (animationConfig.width / 100) / 2),
                width: screenWidth * (animationConfig.width / 100),
                child: Opacity(
                  opacity: animationConfig.opacity,
                  child: Lottie.asset(
                    animationConfig.animationPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (animationConfig.blur > 0 && animationConfig.active)
              Positioned.fill(
                child: BackdropFilter(
                  // blendMode: BlendMode.difference,
                  filter: ImageFilter.blur(
                      sigmaX: animationConfig.blur,
                      sigmaY: animationConfig.blur,
                      tileMode: TileMode.clamp),
                  child: Container(),
                ),
              ),
            SingleChildScrollView(
              physics: widget.scrollPhysics ?? getScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: widget.addSafeAreaMargin ? 70 : 0,
                    ),
                    widget.body,
                  ],
                ),
              ),
            ),
            if (!widget.hideFloatingSpeedDialMenu &&
                AppGeneralSettings.useFloatingSpeedDialMenu)
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
                        : const SizedBox.shrink();
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
