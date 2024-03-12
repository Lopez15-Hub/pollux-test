import 'package:pollux_test/core/data/adapters/model_adapter.dart';
import 'package:sqflite/sqflite.dart';

registerModels(Database db) async => await ModelAdapter.registerTables(db, {
      "Bills": {
        "id": "INTEGER PRIMARY KEY",
        "description": "TEXT",
        "category": "TEXT",
        "amount": "REAL",
      },
      "Categories": {
        "id": "INTEGER PRIMARY KEY",
        "name": "TEXT",
        "color": "INTEGER",
      }
    });
