import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../repositories/summary_repository.dart';

class CloseMonthAndGenerateSummaryUseCase {
  final SummaryRepository repository;

  CloseMonthAndGenerateSummaryUseCase(this.repository);

  Future<Either<Failure, void>> call(int year, int month) async {
    try {
      // El repositorio físico SummaryRepository realiza esta lógica "End Of Month"
      // de forma atómica en SQLite: 1. Leer estadísticas instanciando Models, 2. Guardar Summary, 3. Borrar filas físicas.
      await repository.processEndOfMonth(year, month);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Error inesperado al cerrar el mes: $e'));
    }
  }
}
