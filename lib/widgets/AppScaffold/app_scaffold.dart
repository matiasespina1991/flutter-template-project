import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../../config.dart';
import '../../helpers/theme_notifier.dart';
import '../AppBar/template_app_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final bool hideSpeedDial;

  const AppScaffold({
    super.key,
    required this.body,
    this.hideSpeedDial = false,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);

    return Scaffold(
      appBar: Config.useTopAppBar
          ? const TemplateAppBar(
              title: 'Home',
            )
          : null,
      body: Stack(
        children: [
          body,
          if (!hideSpeedDial && Config.useSpeedDial)
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
        visible: !hideSpeedDial && Config.useSpeedDial ? true : false,
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
