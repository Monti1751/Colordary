import 'package:sqflite/sqflite.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/error/exceptions.dart' as app_ex;
import '../../domain/entities/daily_entry.dart';
import '../../domain/repositories/diary_repository.dart';
import '../models/daily_entry_model.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DatabaseHelper _dbHelper;

  DiaryRepositoryImpl({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<DailyEntry?> getEntryByDate(DateTime date) async {
    try {
      final db = await _dbHelper.database;
      final dateStr = date.toIso8601String().substring(0, 10);

      final maps = await db.query(
        AppStrings.tableDiary,
        where: 'substr(${AppStrings.columnDate}, 1, 10) = ?',
        whereArgs: [dateStr],
      );

      if (maps.isNotEmpty) {
        return DailyEntryModel.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      throw app_ex.DatabaseException('Error al obtener la entrada del diario: $e');
    }
  }

  @override
  Future<List<DailyEntry>> getEntriesForMonth(int year, int month) async {
    try {
      final db = await _dbHelper.database;
      final monthStr = month.toString().padLeft(2, '0');
      final yearMonthStr = '$year-$monthStr';

      final maps = await db.query(
        AppStrings.tableDiary,
        where: 'substr(${AppStrings.columnDate}, 1, 7) = ?',
        whereArgs: [yearMonthStr],
        orderBy: '${AppStrings.columnDate} ASC',
      );

      return maps.map((map) => DailyEntryModel.fromMap(map)).toList();
    } catch (e) {
      throw app_ex.DatabaseException('Error al obtener las entradas del mes: $e');
    }
  }

  @override
  Future<void> saveEntry(DailyEntry entry) async {
    try {
      final now = DateTime.now();
      if (entry.date.year != now.year ||
          entry.date.month != now.month ||
          entry.date.day != now.day) {
        throw app_ex.DatabaseException('No se puede crear o guardar una entrada de un día que no sea el actual.');
      }
      
      final db = await _dbHelper.database;
      final model = DailyEntryModel.fromEntity(entry);

      await db.insert(
        AppStrings.tableDiary,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      if (e is app_ex.DatabaseException) rethrow;
      throw app_ex.DatabaseException('Error al guardar la entrada del diario: $e');
    }
  }

  @override
  Future<void> updateEntry(DailyEntry entry) async {
    try {
      final now = DateTime.now();
      if (entry.date.year != now.year ||
          entry.date.month != now.month ||
          entry.date.day != now.day) {
        throw app_ex.DatabaseException('No se puede modificar una entrada de un día anterior al actual.');
      }

      final db = await _dbHelper.database;
      final model = DailyEntryModel.fromEntity(entry);

      await db.update(
        AppStrings.tableDiary,
        model.toMap(),
        where: '${AppStrings.columnId} = ?',
        whereArgs: [model.id],
      );
    } catch (e) {
      if (e is app_ex.DatabaseException) rethrow;
      throw app_ex.DatabaseException('Error al actualizar la entrada: $e');
    }
  }
}
