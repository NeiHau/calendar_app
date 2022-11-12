import 'package:first_app/model/db/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/model/freezed/event_state_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift/drift.dart';

final todoDatabaseProvider = StateNotifierProvider((_) {
  TodoDatabaseNotifier notify = TodoDatabaseNotifier();
  notify.readData();
  //初期化処理
  return notify;
});

class TodoDatabaseNotifier extends StateNotifier<TodoStateData> {
  //データベースの状態が変わるたびTodoのviewをビルドするようにするクラスです。
  TodoDatabaseNotifier() : super(TodoStateData());
  //ここからはデータベースに関する処理をこのクラスで行えるように記述します。
  final _db = MyDatabase();
  //書き込み処理部分
  writeData(Event data) async {
    if (data.title.isEmpty) {
      return;
    }
    TodoItemCompanion entry = TodoItemCompanion(
      title: Value(data.title),
      startDate: Value(data.startDate),
      endDate: Value(data.endDate),
      description: Value(data.description),
    );

    await _db.writeTodo(entry);
    readData();
    //書き込むたびにデータベースを読み込む
  }

  //削除処理部分
  deleteData(TodoItemData data) async {
    //state = state.copyWith();
    await _db.deleteTodo(data.id);
    readData();
    //削除するたびにデータベースを読み込む
  }

  //更新処理部分
  updateData(TodoItemData data) async {
    if (data.title.isEmpty) {
      return;
    }
    //state = state.copyWith(isLoading: true);
    await _db.updateTodo(data);
    readData();
    //更新するたびにデータベースを読み込む
  }

  //データ読み込み処理
  readData() async {
    //state = state.copyWith(isLoading: true);

    final todoItems = await _db.readAllTodoData();

    state = state.copyWith(
      isReadyData: true,
      todoItems: todoItems,
    );
    /*
    state = state.copyWith(
      todoItems: todoItems,
    );
    */
    //stateを更新します
    //freezedを使っているので、copyWithを使うことができます
    //これは、stateの中身をすべて更新する必要がありません。例えば
    //state.copyWith(isLoading: true)のように一つの値だけを更新することもできます。
    //複数の値を監視したい際、これはとても便利です。
  }
}
