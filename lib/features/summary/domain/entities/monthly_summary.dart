import '../../../../core/enums/emotion.dart';

class MonthlySummary {
  final int year;
  final int month;
  
  /// Conteo de cuántas veces se seleccionó cada emoción en ese mes.
  /// Ej: {Emotion.happy: 12, Emotion.sad: 3...}
  final Map<Emotion, int> emotionCounts;

  const MonthlySummary({
    required this.year,
    required this.month,
    required this.emotionCounts,
  });
}
