import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite_dev.dart';
import '../../../model/entities/goal.dart';

class GoalProvider {
  static final GoalProvider _instance = GoalProvider._internal();
  Database? _database;

  factory GoalProvider() => _instance;

  GoalProvider._internal() {
    init();
  }

  Future<void> init() async {
    String path = join(await getDatabasesPath(), 'goal.db');
    _database = await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableGoal (
        $columnId TEXT PRIMARY KEY,
        $columnParentId TEXT NOT NULL DEFAULT 'root',
        $columnContent TEXT NOT NULL,
        $columnGoalDate INTEGER NOT NULL,
        $columnPriority INTEGER NOT NULL DEFAULT 99,
        $columnDone INTEGER DEFAULT 0
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      await init();
    }
    return _database!;
  }

  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), 'goal.db');
    await sqfliteDatabaseFactoryDefault.deleteDatabase(path);
  }

  Future<void> insert(Goal goal) async {
    final db = await database;
    await db.insert('goal', goal.toMap());
  }

  Future<Goal> getGoal(Goal goal) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('goal', where: '$columnId = ?', whereArgs: [goal.getId]);
    return Goal(
      id: maps[0][columnId],
      parentId: maps[0][columnParentId],
      content: maps[0][columnContent],
      goalDate: maps[0][columnGoalDate],
      priority: maps[0][columnPriority],
      done: maps[0][columnDone] == 1,
    );
  }

  Future<void> update(Goal goal) async {
    final db = await database;
    await db.update(
      'goal',
      goal.toMap(),
      where: '$columnId = ?',
      whereArgs: [goal.getId],
    );
  }

  Future<void> remove(Goal goal) async {
    final db = await database;
    await db.delete(
      'goal',
      where: '$columnId = ?',
      whereArgs: [goal.getId],
    );
  }

  Future<void> removeAll() async {
    final db = await database;
    await db.delete('goal');
  }

  Future<List<Goal>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('goal', orderBy: '$columnPriority ASC');

    return List.generate(maps.length, (i) {
      var goalDate = int.parse(maps[i][columnPriority].toString());
      // _logger.i('goalDate: $goalDate');
      return Goal(
        id: maps[i][columnId],
        parentId: maps[i][columnParentId],
        content: maps[i][columnContent],
        goalDate: DateTime.fromMillisecondsSinceEpoch(goalDate),
        priority: maps[i][columnPriority],
        done: maps[i][columnDone] == 1,
      );
    });
  }

  Future<List<Goal>> getCompleted(bool not) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'goal',
      where: '$columnDone = ?',
      whereArgs: [not ? 0 : 1],
      orderBy: '$columnPriority ASC',
    );

    return List.generate(maps.length, (i) {
      var goalDate = int.parse(maps[i][columnPriority].toString());
      // _logger.i('goalDate: $goalDate');
      return Goal(
        id: maps[i][columnId],
        parentId: maps[i][columnParentId],
        content: maps[i][columnContent],
        goalDate: DateTime.fromMillisecondsSinceEpoch(goalDate),
        priority: maps[i][columnPriority],
        done: maps[i][columnDone] == 1,
      );
    });
  }

  Future<List<Goal>> getRoots({bool done = false}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'goal',
      where: '$columnParentId = ? AND $columnDone = ?',
      whereArgs: ['root', done ? 1 : 0],
      orderBy: '$columnPriority ASC',
    );

    return List.generate(maps.length, (i) {
      var goalDate = int.parse(maps[i][columnPriority].toString());
      return Goal(
        id: maps[i][columnId],
        parentId: maps[i][columnParentId],
        content: maps[i][columnContent],
        goalDate: DateTime.fromMillisecondsSinceEpoch(goalDate),
        priority: maps[i][columnPriority],
        done: maps[i][columnDone] == 1,
      );
    });
  }

  Future<List<Goal>> getChildren(parentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'goal',
      where: '$columnParentId = ? AND $columnDone = ?',
      whereArgs: [parentId, 0],
      orderBy: '$columnPriority ASC',
    );

    return List.generate(maps.length, (i) {
      var goalDate = int.parse(maps[i][columnPriority].toString());
      return Goal(
        id: maps[i][columnId],
        parentId: maps[i][columnParentId],
        content: maps[i][columnContent],
        goalDate: DateTime.fromMillisecondsSinceEpoch(goalDate),
        priority: maps[i][columnPriority],
        done: maps[i][columnDone] == 1,
      );
    });
  }
}
