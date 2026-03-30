import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../entities/daily_entry.dart';
import '../repositories/diary_repository.dart';

class GetMonthlyEntriesUseCase {
  final DiaryRepository repository;

  GetMonthlyEntriesUseCase(this.repository);

  Future<Either<Failure, List<DailyEntry>>> call(int year, int month) async {
    try {
      final entries = await repository.getEntriesForMonth(year, month);
      return Right(entries);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Error inesperado al cargar las entradas del mes.'));
    }
  }
}
