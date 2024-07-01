import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_app/app_settings/app_general_settings.dart';
import 'package:template_app/widgets/AppScaffold/app_scaffold.dart';
import '../../generated/l10n.dart';
import '../../providers/providers_all.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool useAppBar = AppGeneralSettings.useTopAppBar;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  double _sliderValue = 0.0;
  int _stepperIndex = 0;
  bool exampleSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      addSafeAreaMargin: true,
      appBarTitle: S.of(context).homeScreenTitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(S.of(context).exampleTitle,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(S.of(context).exampleDescription,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            Text(S.of(context).buttonsSectionTitle,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text(S.of(context).elevatedButtonLabel),
            ),
            TextButton(
              onPressed: () {},
              child: Text(S.of(context).textButtonLabel),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(S.of(context).outlinedButtonLabel),
            ),
            const SizedBox(height: 20),
            Text(S.of(context).switchesSectionTitle,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            SwitchListTile(
              title: Text(S.of(context).exampleSwitch),
              value: exampleSwitchValue,
              onChanged: (value) {
                setState(() {
                  exampleSwitchValue = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(S.of(context).inputsSectionTitle,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).textFieldLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(S.of(context).steppersSectionTitle,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).lightMode,
                  style: TextStyle(
                    fontWeight: Theme.of(context).brightness == Brightness.light
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                const Text(
                  ' / ',
                ),
                Text(
                  S.of(context).darkMode,
                  style: TextStyle(
                    fontWeight: Theme.of(context).brightness == Brightness.dark
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Center(
              child: Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                activeTrackColor: Theme.of(context).colorScheme.secondary,
                onChanged: (value) {
                  ref.read(themeProvider).toggleTheme(value);
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(localeProvider).setLocale(const Locale('en'));
                  },
                  child: const Text(
                    '🇺🇸',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('/'),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    ref.read(localeProvider).setLocale(const Locale('es'));
                  },
                  child: const Text(
                    '🇪🇸',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('/'),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    ref.read(localeProvider).setLocale(const Locale('de'));
                  },
                  child: const Text(
                    '🇩🇪',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(S.of(context).chipsSectionTitle,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                Chip(label: Text(S.of(context).chipOneLabel)),
                Chip(label: Text(S.of(context).chipTwoLabel)),
                Chip(label: Text(S.of(context).chipThreeLabel)),
              ],
            ),
            const SizedBox(height: 20),
            Text(S.of(context).slidersSectionTitle,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            Slider(
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              min: 0,
              max: 100,
            ),
            Text(
                '${S.of(context).sliderValueLabel}: ${_sliderValue.toStringAsFixed(1)}'),
            Stepper(
              currentStep: _stepperIndex,
              onStepTapped: (index) {
                setState(() {
                  _stepperIndex = index;
                });
              },
              onStepContinue: () {
                if (_stepperIndex < 2) {
                  setState(() {
                    _stepperIndex++;
                  });
                }
              },
              onStepCancel: () {
                if (_stepperIndex > 0) {
                  setState(() {
                    _stepperIndex--;
                  });
                }
              },
              steps: [
                Step(
                  title: Text(S.of(context).stepOneTitle),
                  content: Text(S.of(context).stepOneContent),
                  isActive: _stepperIndex == 0,
                ),
                Step(
                  title: Text(S.of(context).stepTwoTitle),
                  content: Text(S.of(context).stepTwoContent),
                  isActive: _stepperIndex == 1,
                ),
                Step(
                  title: Text(S.of(context).stepThreeTitle),
                  content: Text(S.of(context).stepThreeContent),
                  isActive: _stepperIndex == 2,
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
