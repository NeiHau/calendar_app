import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'todo_item_data.g.dart';

class TodoItem extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title =>
      text().withDefault(const Constant('')).withLength(min: 1)();

  TextColumn get description => text().withDefault(const Constant(''))();

  DateTimeColumn get startDate => dateTime().nullable()();

  DateTimeColumn get endDate => dateTime().nullable()();

  BoolColumn get shujitsuBool => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [TodoItem])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //全てのデータ取得
  Future<List<TodoItemData>> readAllTodoData() => select(todoItem).get();

  //追加
  Future writeTodo(TodoItemCompanion data) => into(todoItem).insert(data);

  //更新
  Future updateTodo(TodoItemData data) => update(todoItem).replace(data);

  //削除
  Future deleteTodo(int id) =>
      (delete(todoItem)..where((it) => it.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
