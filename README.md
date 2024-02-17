# template_app

Template Flutter project.

# Renaming a Flutter App from `template_app` to a Custom Name

1. **Change Package/Bundle ID:**
    - **Android:** Edit `android/app/src/main/AndroidManifest.xml` and change the `package` attribute.
    - **iOS:** Change `PRODUCT_BUNDLE_IDENTIFIER` in `ios/Runner.xcodeproj/project.pbxproj`.

2. **Update Configuration Files:**
    - Modify `applicationId` in `android/app/build.gradle`.
    - Update Firebase configurations if used (`google-services.json` for Android, `GoogleService-Info.plist` for iOS).

3. **Rename Project Folder:**
    - Rename your project folder to `template_app`.

4. **Update Dart Code References:**
    - Update any Dart code references to the package name.

5. **Update App Name:**
    - Change the name in `pubspec.yaml` under the `name` field.

6. **Clean and Rebuild the Project:**
    - Run `flutter clean`.
    - Run `flutter pub get`.
    - Rebuild the project for both platforms.

7. **Check Platform-Specific Configurations:**
    - **Android:** Review `build.gradle` and `settings.gradle`.
    - **iOS:** Adjust settings in Xcode, including project name, targets, and `Info.plist`.

8. **Update External Service References:**
    - Update the app name in external services (Firebase, APIs, etc.) as needed.
