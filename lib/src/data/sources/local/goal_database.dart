import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/model/entities/reason.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GoalDatabase {
  static final GoalDatabase instance = GoalDatabase._init();
  static Database? _database;
  factory GoalDatabase() => instance;

  GoalDatabase._init() {
    _initDB();
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'goal.db');
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableReason (
        $columnReasonId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnGoalId TEXT NOT NULL,
        $columnReason TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE goal (
        $columnId TEXT PRIMARY KEY,
        $columnParentId TEXT NOT NULL DEFAULT 'root',
        $columnContent TEXT NOT NULL,
        $columnGoalDate INTEGER NOT NULL,
        $columnStartDate INTEGER NOT NULL,
        $columnPriority INTEGER NOT NULL DEFAULT 99,
        $columnDone INTEGER DEFAULT 0
      )
    ''');
  }

  Future deleteDB() async {
    final path = join(await getDatabasesPath(), 'goal.db');
    await deleteDatabase(path);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
