class TimestampTable {
  static const table = 'timestamp';
  static const create =
      '''
CREATE TABLE IF NOT EXISTS $table(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  type TEXT NOT NULL,
  hour INTEGER NOT NULL,
  minute INTEGER NOT NULL,
  headacheId INTEGER NOT NULL,
  FOREIGN KEY (headacheId) REFERENCES headache(id)
)
''';
}
