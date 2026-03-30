import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../diary/domain/repositories/diary_repository.dart';
import '../../../../core/enums/emotion.dart';
import 'package:share_plus/share_plus.dart';

class ExportMonthDataUseCase {
  final DiaryRepository repository;

  ExportMonthDataUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required int year,
    required int month,
    required String dateLabel,
    required String emotionLabel,
    required String reflectionLabel,
    required Map<Emotion, String> emotionNames,
  }) async {
    try {
      final entries = await repository.getEntriesForMonth(year, month);
      
      if (entries.isEmpty) {
        return const Left(ValidationFailure('No hay datos escritos en este mes para exportar.'));
      }

      final buffer = StringBuffer();
      final monthStr = month.toString().padLeft(2, '0');
      
      // Request: Change "DIARIO COZY" to "COLORDARY"
      buffer.writeln('=== COLORDARY: $monthStr/$year ===\n');

      for (var entry in entries) {
        final dayStr = entry.date.day.toString().padLeft(2, '0');
        buffer.writeln('$dateLabel: $dayStr/$monthStr/${entry.date.year}');
        
        final emotionName = emotionNames[entry.emotion] ?? entry.emotion.name.toUpperCase();
        buffer.writeln('$emotionLabel: $emotionName');
        
        buffer.writeln('$reflectionLabel:\n${entry.content}');
        buffer.writeln('\n------------------------------------------------\n');
      }

      await Share.share(buffer.toString(), subject: 'Colordary_Export_$year\_$month.txt');
      
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Error inesperado al exportar: $e'));
    }
  }
}
