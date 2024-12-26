import 'package:db_minar/QuotesApp/Model/quotesModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper{
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future get database async => _db ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'finance.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE likedQuotes (
            category TEXT,
            quote TEXT,
            author TEXT,
            isLiked TEXT
          )''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future<void> insertLikedQuote(QuotesModel quote) async {
    final db = await database;
    await db.insert(
      'likedQuotes',
      quote.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteLikedQuotes(String quote) async {
    final db = await database;
    await db.delete(
      'likedQuotes',
      where: 'quote = ?',
      whereArgs: [quote]
    );
  }

  Future<List<QuotesModel>> getLikedQuotes() async{
    final db = await database;
    final List<Map<String,dynamic>> maps =await db.query('likedQuotes');

    return List.generate(maps.length, (i) {
      return QuotesModel.fromJson(maps[i]);
    });
  }
}
