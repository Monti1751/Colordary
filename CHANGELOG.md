# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2026-04-01

### Added
- **Smart Daily Notifications**: Enhanced notification system that only sends reminders when the diary entry for the day is empty
- **Multi-Language Notifications**: Notifications now display in the user's selected language (11 languages supported)
- **Notification Auto-Reprogramming**: When users complete their diary entry, the notification automatically reschedules for the next day

### Fixed
- Fixed notification scheduling to respect user's timezone
- Improved notification delivery reliability on Android 12+
- Ensured notification messages are properly localized based on app language settings

### Technical Improvements
- Implemented `IsDiaryEmptyCallback` for flexible diary state checking
- Added `setDiaryEmptyChecker()` method for dynamic callback registration
- Integrated `scheduleDailyReminderIfEmpty()` method for intelligent notification dispatching
- Added `sendTestNotification()` for testing notification functionality

## [1.0.0] - 2026-03-30

### Added
- **Emotional Tracking**: Core feature to log daily emotions with color-coded entries
- **Diary Management**: Full CRUD operations for diary entries with timestamps and emotion tags
- **Analytics Dashboard**: Visual representation of emotional patterns with FL Chart integration
- **Local Authentication**: Biometric authentication (fingerprint and face recognition) support
- **Daily Notifications**: Reminder system to encourage journaling
- **Multi-Language Support**: Localization for 10 languages:
  - English
  - Spanish
  - Catalan
  - German
  - French
  - Italian
  - Japanese
  - Korean
  - Portuguese
  - Russian
- **Customizable Themes**: Multiple color themes to personalize the app experience
- **Offline-First Architecture**: All data stored locally using SQLite
- **Clean Architecture**: Well-organized project structure with separation of concerns
- **State Management**: Riverpod-based state management for predictable app behavior
- **Immersive UI**: Full-screen immersive experience with custom status bar styling
- **Data Persistence**: Automatic data backup and recovery with local database

### Technical Details
- Built with Flutter 3.3.0+
- Uses Riverpod 2.5.1 for state management
- SQLite database via sqflite package
- Local biometric authentication via local_auth
- Interactive charts with fl_chart
- Comprehensive dependency injection pattern

### Security Features
- Local-only data storage with no cloud transmission
- Biometric authentication for sensitive access
- No tracking or analytics collection
- Privacy-first design approach

### Testing
- Unit tests included
- Widget tests for UI components
- Test coverage with mockito

### Known Limitations
- Offline-only functionality (no cloud sync)
- Android-only release (iOS support planned for future versions)

---

## [Unreleased]

### Planned for Future Releases
- Cloud synchronization with encrypted backup
- Export diary entries to PDF/JSON
- Advanced analytics and mood prediction
- Dark mode theme option
- Voice note recording
- Photo attachment to diary entries
- Search and filter functionality
- Mood reminder scheduling
- Integration with health apps
- iOS version release

---

## Versioning Convention

- **MAJOR** version for incompatible API changes
- **MINOR** version for added functionality in a backwards-compatible manner
- **PATCH** version for backwards-compatible bug fixes

## Reporting Issues

If you discover a bug or have suggestions, please open an issue on [GitHub](https://github.com/Monti1751/Colordary/issues).

---

**Last Updated**: 30 March 2026
