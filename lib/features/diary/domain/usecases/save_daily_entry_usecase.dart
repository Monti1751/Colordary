import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../entities/daily_entry.dart';
import '../repositories/diary_repository.dart';

class SaveDailyEntryUseCase {
  final DiaryRepository repository;

  SaveDailyEntryUseCase(this.repository);

  Future<Either<Failure, void>> call(DailyEntry entry) async {
    if (!entry.isEditable) {
      return const Left(ValidationFailure('Solo se puede editar la entrada del día en curso.'));
    }

    try {
      if (entry.id == null) {
        await repository.saveEntry(entry);
      } else {
        await repository.updateEntry(entry);
      }
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Error inesperado al guardar la entrada: $e'));
    }
  }
}
