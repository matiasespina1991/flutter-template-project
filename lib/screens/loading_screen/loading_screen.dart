import 'package:flutter/material.dart';

import '../../config.dart';
import '../../widgets/LoadingCircle/loading_circle.dart';
import '../../widgets/ThemeAppBar/template_app_bar.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: Config.useTopAppBar
          ? ThemeAppBar(
              title: '',
            )
          : null,
      backgroundColor: isDarkMode
          ? Config.scaffoldBackgroundColor.darkThemeColor
          : Config.scaffoldBackgroundColor.lightThemeColor,
      body: const Center(
        child: LoadingCircle(),
      ),
    );
  }
}
