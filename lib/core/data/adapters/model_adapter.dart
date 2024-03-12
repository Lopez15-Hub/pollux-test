import 'package:flutter/material.dart';
import 'package:pollux_test/core/data/services/sqlite_service.dart';
import 'package:sqflite/sqflite.dart';

abstract class ModelAdapter<Entity> {
  final _db = SqliteService.instance.db;
  final String _table, _primaryKey;
  ModelAdapter(this._table, {String primaryKey = "id"})
      : _primaryKey = primaryKey;

  Future<Entity?> findById(int id) async {
    if (_db != null) {
      final List<Map<String, dynamic>> results = await _db.query(
        _table,
        where: "ID = ?",
        whereArgs: [id],
      );

      return results.isNotEmpty ? fromMap(results.first) : null;
    }
    throw _initializedError();
  }

  Future<List<Entity>> findAll() async {
    if (_db != null) {
      final results = await _db.query(_table);
      return results
          .map((result) => fromMap(result))
          .toList()
          .reversed
          .toList();
    }
    throw _initializedError();
  }

  Future<List<Entity>> findAndGroupBy(String field) async {
    if (_db != null) {
      final results = await _db.query(_table, groupBy: field);
      return results
          .map((result) => fromMap(result))
          .toList()
          .reversed
          .toList();
    }
    throw _initializedError();
  }

  updateOne(int id, Map<String, dynamic> newData) async {
    return await _db!
        .update(_table, newData, where: "$_primaryKey= ?", whereArgs: [id]);
  }

  Future<int?> count({String where = "", List<Object?>? whereArgs}) async {
    if (_db != null) {
      final results = await _db.rawQuery(
          'SELECT COUNT(*) FROM $_table WHERE $where', whereArgs);
      return Sqflite.firstIntValue(results);
    }
    throw _initializedError();
  }

  Future<dynamic> create(ModelAdapter data) async {
    try {
      if (_db != null) {
        await _db.insert(
          _table,
          (data).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (error) {
      throw _initializedError();
    }
  }

  deleteOne(int id) async {
    if (_db != null) {
      await _db.delete(_table, where: "$_primaryKey=?", whereArgs: [id]);
    }
  }

  deleteWhere(String where, List whereArgs) async {
    if (_db != null) {
      await _db.delete(_table, where: where, whereArgs: whereArgs);
    }
  }

  Map<String, dynamic> toMap();
  Entity fromMap(Map<String, dynamic> data);

  static addTable(String table, Map<String, String> data) {
    return _convertToSql(data: data, table: table);
  }

  static registerTables(
      Database db, Map<String, Map<String, String>> tables) async {
    for (var entry in tables.entries) {
      final tableName = entry.key;
      final tableDefinition = entry.value;

      final existingTables = await db.query('sqlite_master',
          columns: ['name'],
          where: 'type = ? AND name = ?',
          whereArgs: ['table', tableName]);

      if (existingTables.isEmpty) {
        final query = addTable(tableName, tableDefinition);

        try {
          await db.execute(query);
        } catch (error) {
          debugPrint('Error creating table $tableName: $error');
        }
      } else {
        debugPrint('Table $tableName already exists, skipping creation');
      }
    }
  }

  static String _convertToSql(
      {String table = "", required Map<String, String> data}) {
    final List<String> columnDefinitions =
        data.entries.map((entry) => '${entry.key} ${entry.value}').toList();

    final String columns = columnDefinitions.join(', ');

    return 'CREATE TABLE $table ($columns)';
  }

  _initializedError() => throw Exception("Base de datos no iniciada");
}
