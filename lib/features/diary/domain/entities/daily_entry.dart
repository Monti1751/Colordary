import '../../../../core/enums/emotion.dart';

class DailyEntry {
  final int? id;
  final DateTime date;
  final String content;
  final Emotion emotion;

  const DailyEntry({
    this.id,
    required this.date,
    required this.content,
    required this.emotion,
  });

  /// Regla de Negocio: Inmutabilidad del Pasado
  /// Solo se puede editar la entrada si pertenece al día en curso.
  bool get isEditable {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }
}
