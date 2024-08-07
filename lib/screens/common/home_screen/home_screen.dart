import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gpguard_poc/app_settings/app_general_settings.dart';
import 'package:gpguard_poc/widgets/AppScaffold/app_scaffold.dart';
import '../../../generated/l10n.dart';
import '../../../providers/providers_all.dart';
import '../../../routes/routes.dart';
import '../../../utils/ui/is_dark_mode.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool useAppBar = AppGeneralSettings.useTopAppBar;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  int _sliderValue = 0;
  int _stepperIndex = 0;
  bool exampleSwitchValue = false;
  static const bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.watch(themeProvider);

    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
    return AppScaffold(
      isProtected: true,
      appBarTitle: S.of(context).homeScreenTitle,
      body: Skeletonizer(
        enabled: isLoading,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.push(Routes.scannerScreen.path);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 47),
                  ),
                  child: Text('Open scanner')),
            ],
          ),
        ),
      ),
    );
  }
}
