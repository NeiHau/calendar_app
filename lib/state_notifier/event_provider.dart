import 'package:first_app/model/database/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/model/freezed/event_list.dart';
import 'package:first_app/state_notifier/event_map_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift/drift.dart';

final startDateProvider = StateProvider(((ref) => DateTime.now()));
final endDateProvider = StateProvider(((ref) => DateTime.now));

final todoDatabaseProvider =
    StateNotifierProvider<TodoDatabaseNotifier, TodoEventList>((ref) {
  return TodoDatabaseNotifier(ref);
});

// データベースの状態が変わるたびTodoListのviewをビルドするクラス。
class TodoDatabaseNotifier extends StateNotifier<TodoEventList> {
  TodoDatabaseNotifier(this.ref) : super(TodoEventList());

  final Ref ref;
  final _db = MyDatabase();

  // 書き込み処理部分
  Future<void> writeData(TodoItemData data) async {
    if (data.title.isEmpty) {
      return;
    }
    TodoItemCompanion entry = TodoItemCompanion(
      id: Value(data.id),
      title: Value(data.title),
      startDate: Value(data.startDate),
      endDate: Value(data.endDate),
      description: Value(data.description),
      shujitsuBool: Value(data.shujitsuBool),
    );

    await _db.writeTodo(entry);

    // 書き込むたびにデータベースを読み込んで、マップ型のデータに格納する。
    readData();
    ref.read(eventStateProvider.notifier).readDataMap();
  }

  // 削除処理部分
  Future<void> deleteData(Event data) async {
    await _db.deleteTodo(data);

    // 削除するたびにデータベースを読み込んで、マップ型に落とし込む。
    readData();
    ref.read(eventStateProvider.notifier).readDataMap();
  }

  // 更新処理部分
  Future<void> updateData(TodoItemData data) async {
    if (data.title.isEmpty) {
      return;
    }
    await _db.updateTodo(data);

    // 更新するたびにデータベースを読み込む。
    readData();
    ref.read(eventStateProvider.notifier).readDataMap();
  }

  // データ読み込み処理
  Future<void> readData() async {
    final todoItems = await _db.readAllTodoData();

    List<Event> todoList = [];
    for (int i = 0; i < todoItems.length; i++) {
      todoList.add(Event(
          id: todoItems[i].id,
          title: todoItems[i].title,
          description: todoItems[i].description,
          startDate: todoItems[i].startDate,
          endDate: todoItems[i].endDate,
          isAllDay: todoItems[i].shujitsuBool));
    }

    state = state.copyWith(
      todoItems: todoList,
    );
  }
}
