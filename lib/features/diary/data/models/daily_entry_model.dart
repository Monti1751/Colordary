import '../../../../core/enums/emotion.dart';
import '../../domain/entities/daily_entry.dart';
import '../../../../core/constants/app_strings.dart';

class DailyEntryModel extends DailyEntry {
  const DailyEntryModel({
    int? id,
    required DateTime date,
    required String content,
    required Emotion emotion,
  }) : super(id: id, date: date, content: content, emotion: emotion);

  factory DailyEntryModel.fromMap(Map<String, dynamic> map) {
    return DailyEntryModel(
      id: map[AppStrings.columnId] as int?,
      date: DateTime.parse(map[AppStrings.columnDate] as String),
      content: map[AppStrings.columnContent] as String,
      emotion: Emotion.values[map[AppStrings.columnEmotionIndex] as int],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) AppStrings.columnId: id,
      AppStrings.columnDate: date.toIso8601String(),
      AppStrings.columnContent: content,
      AppStrings.columnEmotionIndex: emotion.index,
    };
  }

  factory DailyEntryModel.fromEntity(DailyEntry entity) {
    return DailyEntryModel(
      id: entity.id,
      date: entity.date,
      content: entity.content,
      emotion: entity.emotion,
    );
  }
}
