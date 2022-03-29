import 'package:ditonton/data/models/tv_show_table.dart';
import 'package:sqflite/sqflite.dart';

class TvDatabaseHelper {
  static TvDatabaseHelper? _tvDatabaseHelper;
  TvDatabaseHelper._instance() {
    _tvDatabaseHelper = this;
  }

  factory TvDatabaseHelper() =>
      _tvDatabaseHelper ?? TvDatabaseHelper._instance();

  static Database? _database2;

  Future<Database?> get database2 async {
    if (_database2 == null) {
      _database2 = await _initDb();
    }
    return _database2;
  }

  static const String _tblTvWatchlist = 'tv_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton2.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblTvWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTv(TvShowTable tvShow) async {
    final db = await database2;
    return await db!.insert(_tblTvWatchlist, tvShow.toJson());
  }

  Future<int> removeWatchlistTv(TvShowTable tvShow) async {
    final db = await database2;
    return await db!
        .delete(_tblTvWatchlist, where: 'id = ?', whereArgs: [tvShow.id]);
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database2;
    final results = await db!.query(
      _tblTvWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShows() async {
    final db = await database2;
    final List<Map<String, dynamic>> results = await db!.query(_tblTvWatchlist);
    return results;
  }
}
