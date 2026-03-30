import 'package:sqflite/sqflite.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/error/exceptions.dart' as app_ex;
import '../../../../core/enums/emotion.dart';
import '../../domain/entities/monthly_summary.dart';
import '../../domain/repositories/summary_repository.dart';
import '../models/monthly_summary_model.dart';
import '../../../diary/data/models/daily_entry_model.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  final DatabaseHelper _dbHelper;

  SummaryRepositoryImpl({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<void> processEndOfMonth(int year, int month) async {
    try {
      final db = await _dbHelper.database;
      
      await db.transaction((txn) async {
        final monthStr = month.toString().padLeft(2, '0');
        final yearMonthStr = '$year-$monthStr';

        // 1. Obtener entradas del mes
        final maps = await txn.query(
          AppStrings.tableDiary,
          where: 'substr(${AppStrings.columnDate}, 1, 7) = ?',
          whereArgs: [yearMonthStr],
        );

        final Map<Emotion, int> emotionCounts = {
          for (var emotion in Emotion.values) emotion: 0
        };

        for (var map in maps) {
          final entry = DailyEntryModel.fromMap(map);
          emotionCounts[entry.emotion] = (emotionCounts[entry.emotion] ?? 0) + 1;
        }

        final summaryModel = MonthlySummaryModel(
          year: year,
          month: month,
          emotionCounts: emotionCounts,
        );

        // 2. Guardar MonthlySummary
        await txn.insert(
          AppStrings.tableMonthlySummary,
          summaryModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // 3. Eliminar todas las filas (DailyEntry) de ese mes
        await txn.delete(
          AppStrings.tableDiary,
          where: 'substr(${AppStrings.columnDate}, 1, 7) = ?',
          whereArgs: [yearMonthStr],
        );
      });
    } catch (e) {
      throw app_ex.DatabaseException('Error crítico durante el cierre de mes: $e');
    }
  }

  @override
  Future<MonthlySummary?> getSummary(int year, int month) async {
    try {
      final db = await _dbHelper.database;
      final monthStr = month.toString().padLeft(2, '0');
      final yearMonthStr = '$year-$monthStr';

      final maps = await db.query(
        AppStrings.tableMonthlySummary,
        where: '${AppStrings.columnMonthYear} = ?',
        whereArgs: [yearMonthStr],
      );

      if (maps.isNotEmpty) {
        return MonthlySummaryModel.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      throw app_ex.DatabaseException('Error al obtener el resumen mensual: $e');
    }
  }

  @override
  Future<List<MonthlySummary>> getAllSummaries() async {
    try {
      final db = await _dbHelper.database;

      final maps = await db.query(
        AppStrings.tableMonthlySummary,
        orderBy: '${AppStrings.columnMonthYear} DESC',
      );

      return maps.map((map) => MonthlySummaryModel.fromMap(map)).toList();
    } catch (e) {
      throw app_ex.DatabaseException('Error al obtener el historial de resúmenes: $e');
    }
  }
}
