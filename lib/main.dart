import 'package:flutter/material.dart';
import 'package:pollux_test/core/config/config.dart';
import 'package:pollux_test/pollux_test.dart';

import 'core/data/services/sqlite_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteService.instance.init(databaseName: databaseName);
  if (SqliteService.instance.db != null) runApp(const PolluxTest());
}
