import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:template_app/app_settings/app_general_settings.dart';
import 'package:template_app/app_settings/auth_config.dart';
import 'package:template_app/providers/providers_all.dart';
import 'package:template_app/screens/loading_screen/loading_screen.dart';
import 'package:template_app/utils/ui/is_dark_mode.dart';
import '../../app_settings/theme_settings.dart';

import '../../models/general_models.dart';
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
  final bool addSafeAreaMargin;
  final LottieAnimationBackground?
      backgroundAnimation; // Cambiado a LottieAnimationBackground
  final LottieAnimationBackground?
      backgroundAnimationDarkMode; // Nueva propiedad

  const AppScaffold({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.hideFloatingSpeedDialMenu = false,
    this.isProtected = true,
    this.scrollPhysics,
    this.addSafeAreaMargin = false,
    this.backgroundAnimation,
    this.backgroundAnimationDarkMode, // Nueva propiedad
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

  LottieAnimationBackground? getLottieAnimation() {
    final themeIsDark = isDarkMode(context);
    if (themeIsDark && widget.backgroundAnimationDarkMode != null) {
      return widget.backgroundAnimationDarkMode;
    }
    return widget.backgroundAnimation;
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

    final animationConfig = getLottieAnimation();
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
            if (animationConfig != null && animationConfig.active)
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
            if (animationConfig != null &&
                animationConfig.blur > 0 &&
                animationConfig.active)
              Positioned.fill(
                child: BackdropFilter(
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
