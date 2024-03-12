import 'package:pollux_test/core/data/models/models.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static SqliteService? _service;
  final databaseName = "tennis.db";
  SqliteService._internal();
  static SqliteService get instance => _service ??= SqliteService._internal();

  Database? _db;
  Database? get db => _db;
  Future<void> init(
      {required String databaseName, bool recreate = false}) async {
    if (recreate) await deleteDatabase(databaseName);

    _db = await openDatabase(databaseName, version: 1, onOpen: (db) async {
      await registerModels(db);
    }, onCreate: (db, version) async {
      await registerModels(db);
    });
  }
}
