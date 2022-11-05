// For more information on using drift, please see https://drift.simonbinder.eu/docs/getting-started/

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

part 'calendar_item.g.dart';

class TodoItem extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title =>
      text().withDefault(const Constant('')).withLength(min: 1)();
  TextColumn get description => text().withDefault(const Constant(''))();

  DateTimeColumn get startDate => dateTime().nullable()();

  BoolColumn get isNotify => boolean().withDefault(const Constant(true))();
}
