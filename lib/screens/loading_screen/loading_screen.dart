import 'package:flutter/material.dart';

import '../../config.dart';
import '../../widgets/LoadingCircle/loading_circle.dart';
import '../../widgets/ThemeAppBar/template_app_bar.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: Config.useSafeArea,
      child: Scaffold(
        backgroundColor: isDarkMode
            ? Config.scaffoldBackgroundColor.darkModePrimary
            : Config.scaffoldBackgroundColor.lightModePrimary,
        body: const Center(
          child: LoadingCircle(),
        ),
      ),
    );
  }
}
