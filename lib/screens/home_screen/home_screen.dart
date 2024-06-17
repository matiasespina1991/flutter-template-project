import 'dart:ui';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:template_app/widgets/AppBar/template_app_bar.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../helpers/theme_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool useAppBar = Config.useTopAppBar;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Config.useTopAppBar
          ? const TemplateAppBar(
              title: 'Home',
            )
          : null,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Light Mode/Dark Mode',
                ),
                const SizedBox(height: 10),
                Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .toggleTheme(value);
                  },
                ),
              ],
            ),
          ),
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
        visible: true,
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(color: Colors.white),
        activeBackgroundColor: Theme.of(context).colorScheme.secondary,
        activeForegroundColor: Colors.white,
        curve: Curves.easeInOut,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.settings),
            label: 'Settings',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              // Add your action here
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Add',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              // Add your action here
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.remove),
            label: 'Remove',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              // Add your action here
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
  }
}
