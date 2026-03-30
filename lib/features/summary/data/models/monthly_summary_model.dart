import 'dart:convert';
import '../../../../core/enums/emotion.dart';
import '../../domain/entities/monthly_summary.dart';
import '../../../../core/constants/app_strings.dart';

class MonthlySummaryModel extends MonthlySummary {
  const MonthlySummaryModel({
    required int year,
    required int month,
    required Map<Emotion, int> emotionCounts,
  }) : super(year: year, month: month, emotionCounts: emotionCounts);

  factory MonthlySummaryModel.fromMap(Map<String, dynamic> map) {
    final String monthYearStr = map[AppStrings.columnMonthYear] as String;
    final parts = monthYearStr.split('-');
    final int year = int.parse(parts[0]);
    final int month = int.parse(parts[1]);

    final String statsJson = map[AppStrings.columnStatsJson] as String;
    final Map<String, dynamic> decodedStats = json.decode(statsJson);
    
    final Map<Emotion, int> counts = {};
    decodedStats.forEach((key, value) {
      counts[Emotion.values[int.parse(key)]] = value as int;
    });

    return MonthlySummaryModel(
      year: year,
      month: month,
      emotionCounts: counts,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, int> stringKeyedStats = {};
    emotionCounts.forEach((key, value) {
      stringKeyedStats[key.index.toString()] = value;
    });

    final String monthStr = month.toString().padLeft(2, '0');
    final String monthYearStr = '$year-$monthStr';

    return {
      AppStrings.columnMonthYear: monthYearStr,
      AppStrings.columnStatsJson: json.encode(stringKeyedStats),
    };
  }
}
