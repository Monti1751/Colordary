# Colordary 📔

A cozy personal diary application with emotional tracking, built with Flutter. Colordary helps you express your feelings through color-coded entries, track emotional patterns, and gain insights into your emotional journey.

## 🌟 Features

- **Emotional Tracking**: Log your daily emotions with beautiful color-coded entries and detailed notes
- **Diary Management**: Create, read, update, and delete diary entries with timestamps and emotion tags
- **Analytics Dashboard**: Visualize your emotional patterns with interactive charts and statistics
- **Local Authentication**: Secure your diary with fingerprint or face recognition (biometric authentication)
- **Notifications**: Receive daily reminders to journalize your thoughts
- **Multi-Language Support**: Available in English, Spanish, Catalan, German, French, Italian, Japanese, Korean, Portuguese, and Russian
- **Customizable Theme**: Choose between different color themes to match your mood
- **Offline-First**: All data is stored locally on your device for privacy
- **Data Persistence**: Local SQLite database ensures your entries are never lost

## 📋 Requirements

Before you begin, ensure you have the following installed:

- **Flutter**: Version 3.3.0 or higher ([Install Flutter](https://flutter.dev/docs/get-started/install))
- **Dart**: Included with Flutter
- **Android SDK**: API level 21 or higher (for Android development)
- **Java/JDK**: Version 11 or higher
- **Android Studio**: Recommended for development
- **Git**: For cloning the repository

### Verify Installation

Run the following command to verify your Flutter installation:

```bash
flutter doctor
```

All items should have a checkmark for smooth development.

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Monti1751/Colordary.git
cd Colordary
```

### 2. Install Dependencies

```bash
flutter pub get
```

This command downloads all required packages specified in `pubspec.yaml`.

### 3. Run the App on a Connected Device

First, connect an Android device via USB with USB debugging enabled, or start an Android emulator.

```bash
flutter run
```

Or run with a specific device:

```bash
flutter run -d <device-id>
```

To list all connected devices:

```bash
flutter devices
```

## 📱 Building and Installing the APK

### Option 1: Build and Install via Flutter (Recommended)

#### Step 1: Build the Release APK

```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/apk/release/app-release.apk`

#### Step 2: Install on Connected Device

```bash
adb install build/app/outputs/apk/release/app-release.apk
```

Or use Flutter to install directly:

```bash
flutter install
```

### Option 2: Build and Install via Android Studio

1. Connect your Android device or start an emulator
2. Open the project in Android Studio
3. Click **Build** → **Build Bundle(s)/APK(s)** → **Build APK(s)**
4. Once built, click **Build** → **Build Bundle(s)/APK(s)** → **Build & Analyze**
5. In the **apk** folder, right-click the APK file and select **Analyze APK**
6. To install: `adb install <path-to-apk>`

### Option 3: Manual APK Installation on Android Device

#### Prerequisites

- Enable USB debugging on your Android device:
  1. Go to **Settings** → **About Phone**
  2. Tap **Build Number** 7 times to enable Developer Mode
  3. Go back to **Settings** → **Developer Options**
  4. Enable **USB Debugging**

- Connect your device via USB cable to your computer

#### Installation Steps

1. **Build the APK**:
   ```bash
   flutter build apk --release
   ```

2. **Install using ADB**:
   ```bash
   adb devices  # Verify device is connected
   adb install build/app/outputs/apk/release/app-release.apk
   ```

3. **Verify Installation**:
   - The app "Colordary" should now appear in your app drawer
   - Tap to launch the application

#### Troubleshooting APK Installation

- **Device not recognized**: 
  - Ensure USB debugging is enabled
  - Install Android USB drivers if needed
  - Try `adb kill-server && adb start-server`

- **Installation fails with permission error**:
  - Try: `adb uninstall com.colordary.app` (remove old version first)
  - Then reinstall: `adb install build/app/outputs/apk/release/app-release.apk`

- **APK installation via file manager**:
  - Copy the APK file to your device storage
  - Use a file manager app to navigate to the file
  - Tap the APK and select "Install"

## 🗂️ Project Structure

```
lib/
├── main.dart                 # Application entry point
├── core/
│   ├── constants/           # App-wide constants
│   │   ├── app_colors.dart
│   │   ├── app_dimensions.dart
│   │   └── app_strings.dart
│   ├── database/            # Local database configuration
│   │   └── database_helper.dart
│   ├── enums/               # Application enums
│   │   └── emotion.dart
│   ├── error/               # Error handling
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── providers/           # Dependency injection
│   │   └── dependency_providers.dart
│   └── services/            # Core services
│       ├── local_auth_service.dart
│       └── notification_service.dart
├── features/                # Feature modules (CLEAN architecture)
│   ├── auth/               # Authentication feature
│   ├── diary/              # Diary management feature
│   │   ├── data/           # Data layer
│   │   ├── domain/         # Domain/Business logic
│   │   └── presentation/   # UI layer
│   ├── settings/           # Settings feature
│   └── summary/            # Analytics/Summary feature
├── l10n/                    # Localization files
│   ├── app_*.arb           # Translation files for each language
│   └── app_localizations*.dart # Generated localization classes
└── assets/                  # Images, fonts, and other resources
```

## 🏗️ Architecture

Colordary follows the **Clean Architecture** pattern with the following layers:

- **Presentation Layer**: Flutter widgets, providers (Riverpod), and UI logic
- **Domain Layer**: Business logic, entities, repositories contracts, and use cases
- **Data Layer**: Data sources, models, and repository implementations

This architecture ensures:
- Separation of concerns
- Testability
- Maintainability
- Scalability

## 🛠️ Technologies & Libraries

- **Framework**: Flutter 3.3.0+
- **State Management**: Riverpod 2.5.1
- **Local Database**: SQLite (sqflite)
- **Authentication**: Local Biometric (local_auth)
- **Notifications**: Flutter Local Notifications
- **Charts**: FL Chart
- **Localization**: Flutter Intl (10 languages)
- **Fonts**: Google Fonts
- **Functional Programming**: Dartz
- **Testing**: Flutter Test, Mockito

## 🧪 Testing

### Running Tests

Run all unit and widget tests:

```bash
flutter test
```

### Code Coverage

Generate code coverage report:

```bash
flutter test --coverage
```

This creates a coverage report in `coverage/lcov.info`.

#### Generate HTML Coverage Report

To visualize the coverage as an interactive HTML report:

1. **Install lcov** (if not already installed):
   - **macOS**: `brew install lcov`
   - **Linux**: `sudo apt-get install lcov`
   - **Windows**: `choco install lcov`

2. **Generate HTML report**:
   ```bash
   genhtml coverage/lcov.info -o coverage/html
   ```

3. **View the report**:
   - **macOS/Linux**: `open coverage/html/index.html`
   - **Windows**: `start coverage/html/index.html`

#### Using Pre-built Scripts

For convenience, use the included scripts:

**On Windows:**
```bash
.\run_coverage.bat
```

**On macOS/Linux:**
```bash
bash run_coverage.sh
```

These scripts will:
- Run all tests with coverage
- Generate the coverage report
- Provide instructions for creating an HTML report

## 🔐 Security Considerations

- All user data is stored locally on the device
- Sensitive data can be protected with biometric authentication
- No data is sent to external servers
- For production deployment, consider implementing:
  - Code obfuscation: `flutter build apk --obfuscate --split-debug-info=./build/app/outputs/symbols`
  - Data encryption for local storage

## 📦 Building for Production

### Release APK (Recommended for distribution)

```bash
flutter build apk --release
```

### Split APKs (for different architectures)

```bash
flutter build apk --split-per-abi --release
```

This creates optimized APKs for ARM64, ARMv7, and x86.

### Android App Bundle (for Google Play)

```bash
flutter build appbundle --release
```

Generate at: `build/app/outputs/bundle/release/app-release.aab`

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/AmazingFeature`
3. **Commit your changes**: `git commit -m 'Add AmazingFeature'`
4. **Push to the branch**: `git push origin feature/AmazingFeature`
5. **Open a Pull Request**

### Coding Standards

- Follow Flutter and Dart style guides
- Write meaningful commit messages
- Add comments for complex logic
- Ensure all tests pass before submitting PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Authors

- Francisco José Montesinos Silvero - Project Creator

## 🐛 Bug Reports & Feature Requests

Found a bug or have a feature request? Please open an [issue on GitHub](https://github.com/Monti1751/Colordary/issues).

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Riverpod Documentation](https://riverpod.dev/)
- [Android Developer Guide](https://developer.android.com/docs)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors and testers
- Open-source community

---

**Enjoy journaling with Colordary! 💝**
#   C o l o r d a r y  
 