import 'package:headache_tracker/data/database/tables/headache_table.dart';
import 'package:headache_tracker/data/database/tables/timestamp_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static const _dbName = 'app.db';
  static const _dbVersion = 1;

  static final AppDatabase instance = AppDatabase._();
  static Database? _db;

  // ensures only one database instance created
  AppDatabase._();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(HeadacheTable.create);
    await db.execute(TimestampTable.create);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // perform migration logic here...
  }
}
