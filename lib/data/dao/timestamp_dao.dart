import 'package:headache_tracker/data/database/app_database.dart';
import 'package:headache_tracker/data/database/tables/timestamp_table.dart';
import 'package:headache_tracker/models/timestamp.dart';

class TimestampDao {
  final _db = AppDatabase.instance;

  Future<int> insert(Timestamp t) async {
    final db = await _db.database;
    return db.insert(TimestampTable.table, t.toMap());
  }

  Future<void> delete(int headacheId) async {
    final db = await _db.database;
    await db.delete(
      TimestampTable.table,
      where: 'headacheId = ?',
      whereArgs: [headacheId],
    );
  }

  Future<List<Timestamp>> getAll(int headacheId) async {
    final db = await _db.database;
    final result = await db.query(
      TimestampTable.table,
      where: 'headacheId = ?',
      whereArgs: [headacheId],
    );

    return result.map(Timestamp.fromMap).toList();
  }
}
