import '../entities/daily_entry.dart';

abstract class DiaryRepository {
  /// Obtiene la entrada para una fecha en concreto (si existe).
  Future<DailyEntry?> getEntryByDate(DateTime date);

  /// Obtiene todas las entradas del mes actual para pintar el Grid Mensual.
  Future<List<DailyEntry>> getEntriesForMonth(int year, int month);

  /// Guarda una nueva entrada en la base de datos local.
  Future<void> saveEntry(DailyEntry entry);

  /// Actualiza una entrada existente (la validación del día en curso 
  /// debe confirmarse con la propiedad isEditable de la entidad pura).
  Future<void> updateEntry(DailyEntry entry);
}
