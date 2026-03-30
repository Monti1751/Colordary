import '../entities/monthly_summary.dart';

abstract class SummaryRepository {
  /// Realiza el "Cierre de Mes":
  /// 1. Calcula la estadística del mes y guarda el MonthlySummary
  /// 2. Elimina todas las entradas físicas (DailyEntry texto/detalle) de la BBDD para ahorrar espacio
  Future<void> processEndOfMonth(int year, int month);

  /// Obtiene el resumen histórico (gráfica de datos) para un mes concreto
  Future<MonthlySummary?> getSummary(int year, int month);

  /// Obtiene todos los resúmenes anteriores para mostrar el histórico total de gráficas
  Future<List<MonthlySummary>> getAllSummaries();
}
