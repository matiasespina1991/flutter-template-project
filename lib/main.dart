import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_app/providers/authorization_provider.dart';
import 'package:template_app/screens/home_screen/home_screen.dart';
import 'package:template_app/screens/loading_screen/loading_screen.dart';
import 'package:template_app/screens/login_screen/login_screen.dart';
import 'package:template_app/theme/EscribaTheme.dart';

import 'config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthorizationProvider()),
      ],
      child: MaterialApp(
        title: Config.appName,
        theme: TemplateTheme.themeData,
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorizationProvider>(
        builder: (BuildContext context, value, Widget? child) {
          bool isAuthenticated = value.isAuthenticated;

          if (Config.debugMode == true) {
            isAuthenticated = true;
          }

          if (!isAuthenticated) {
            return const LoginScreen();
          }
          return const HomeScreen();
        },
        child: const LoadingScreen());
  }
}
