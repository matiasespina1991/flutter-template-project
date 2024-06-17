import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../../config.dart';
import '../../generated/l10n.dart';
import '../../providers/authorization_provider.dart';
import '../../providers/theme_notifier.dart';

class ThemeFloatingSpeedDialMenu extends StatefulWidget {
  final bool hideFloatingSpeedDialMenu;
  final ValueNotifier<bool> isDialOpenNotifier;

  const ThemeFloatingSpeedDialMenu({
    super.key,
    required this.hideFloatingSpeedDialMenu,
    required this.isDialOpenNotifier,
  });

  @override
  _ThemeFloatingSpeedDialMenuState createState() =>
      _ThemeFloatingSpeedDialMenuState();
}

class _ThemeFloatingSpeedDialMenuState
    extends State<ThemeFloatingSpeedDialMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, child) {
      bool isDarkMode = theme.themeMode == ThemeMode.dark;

      return SpeedDial(
        closeManually:
            false, // If set to true, dont try to add dynamic items or state-dependent items, they wont update
        animationDuration: const Duration(milliseconds: 200),
        elevation: 1.5,
        spacing: 10.0,
        visible:
            widget.hideFloatingSpeedDialMenu | !Config.useFloatingSpeedDialMenu
                ? false
                : true,
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
            child: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            label:
                isDarkMode ? S.of(context).lightMode : S.of(context).darkMode,
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Provider.of<ThemeNotifier>(context, listen: false)
                  .toggleTheme(!isDarkMode);
              setState(() {
                isDarkMode = !isDarkMode;
              });
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
          widget.isDialOpenNotifier.value = true;
        },
        onClose: () {
          widget.isDialOpenNotifier.value = false;
        },
      );
    });
  }
}
