import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../constants/app_strings.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(AppStrings.databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: AppStrings.databaseVersion,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppStrings.tableDiary} (
        ${AppStrings.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppStrings.columnDate} TEXT NOT NULL,
        ${AppStrings.columnContent} TEXT NOT NULL,
        ${AppStrings.columnEmotionIndex} INTEGER NOT NULL
      )
    ''');
    
    await db.execute('''
      CREATE TABLE ${AppStrings.tableMonthlySummary} (
        ${AppStrings.columnMonthYear} TEXT PRIMARY KEY,
        ${AppStrings.columnStatsJson} TEXT NOT NULL
      )
    ''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
