import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/settings_repository.dart';

class UpdateAppSettingsUseCase {
  final SettingsRepository repository;
  UpdateAppSettingsUseCase(this.repository);

  Future<Either<Failure, void>> call({
    String? themeMode,
    bool? isColorblindMode,
    double? fontSizeScale,
    int? emotionPaletteIndex,
    bool? isNotificationsEnabled,
    bool? isAuthEnabled,
    String? languageCode,
  }) async {
    try {
      if (themeMode != null) await repository.saveThemeMode(themeMode);
      if (isColorblindMode != null) await repository.saveColorblindMode(isColorblindMode);
      if (fontSizeScale != null) await repository.saveFontSizeScale(fontSizeScale);
      if (emotionPaletteIndex != null) await repository.saveEmotionPaletteIndex(emotionPaletteIndex);
      if (isNotificationsEnabled != null) await repository.saveNotificationsEnabled(isNotificationsEnabled);
      if (isAuthEnabled != null) await repository.saveAuthEnabled(isAuthEnabled);
      if (languageCode != null) await repository.saveLanguageCode(languageCode);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Error al guardar ajustes: $e'));
    }
  }
}
