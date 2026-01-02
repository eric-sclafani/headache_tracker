import 'package:headache_tracker/data/database/app_database.dart';
import 'package:headache_tracker/data/database/tables/headache_table.dart';
import 'package:headache_tracker/models/headache.dart';

class HeadacheDao {
  final _db = AppDatabase.instance;

  Future<int> insert(Headache h) async {
    final db = await _db.database;
    return db.insert(HeadacheTable.table, h.toMap());
  }

  Future<void> delete(int id) async {
    final db = await _db.database;
    await db.delete(HeadacheTable.table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Headache>> getAll() async {
    final db = await _db.database;
    final result = await db.query(HeadacheTable.table);
    return result.map(Headache.fromMap).toList();
  }
}
