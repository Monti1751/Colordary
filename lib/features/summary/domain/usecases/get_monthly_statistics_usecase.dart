import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../entities/monthly_summary.dart';
import '../repositories/summary_repository.dart';

class GetMonthlyStatisticsUseCase {
  final SummaryRepository repository;

  GetMonthlyStatisticsUseCase(this.repository);

  Future<Either<Failure, List<MonthlySummary>>> call() async {
    try {
      final summaries = await repository.getAllSummaries();
      return Right(summaries);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Error inesperado al cargar el historial de estadísticas.'));
    }
  }
}
