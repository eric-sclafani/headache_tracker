class HeadacheTable {
  static const table = 'headache';
  static const create =
      '''
CREATE TABLE IF NOT EXISTS $table (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  intensity INTEGER NOT NULL,
  occurenceDate TEXT,
  notes TEXT NULL
)
''';
}
