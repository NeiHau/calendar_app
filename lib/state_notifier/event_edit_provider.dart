import 'package:first_app/model/database/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/model/freezed/event_state_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventStateProvider =
    StateNotifierProvider<EventStateNotifier, TodoStateData>((ref) {
  return EventStateNotifier(ref);
});

class EventStateNotifier extends StateNotifier<TodoStateData> {
  EventStateNotifier(this.ref) : super(TodoStateData());

  final Ref ref;
  MyDatabase database = MyDatabase();

  // このメソッド内で、取得したデータをMap型の変数に格納して扱う。
  Future readDataMap() async {
    final eventsAll = await database.readAllTodoData(); // 全てのデータを取得

    state = state.copyWith(todoItemsMap: {});
    final Map<DateTime, List<Event>> dataMap = {};

    final todoList = List.generate(
        eventsAll.length,
        (index) => Event(
            id: eventsAll[index].id,
            title: eventsAll[index].title,
            isAllDay: eventsAll[index].shujitsuBool,
            startDate: eventsAll[index].startDate,
            endDate: eventsAll[index].endDate,
            description: eventsAll[index].description));

    for (final e in todoList) {
      // 開始日
      final startDay =
          DateTime(e.startDate.year, e.startDate.month, e.startDate.day);
      // 終了日
      final endDay = DateTime(e.endDate.year, e.endDate.month, e.endDate.day);

      var difference = endDay.difference(startDay).inDays; // 開始日と終了日の差を計算

      for (int i = 0; i <= difference; i++) {
        final date =
            DateTime(e.startDate.year, e.startDate.month, e.startDate.day + i);

        if (state.todoItemsMap[date] == null) {
          dataMap[date] = [e];
          state = state.copyWith(todoItemsMap: dataMap);
        } else {
          if (dataMap[date] == null) {
            dataMap[date] = [e];
            state = state.copyWith(todoItemsMap: dataMap);
          } else {
            dataMap[date]!.add(e);
            state = state.copyWith(todoItemsMap: dataMap);
          }
        }
      }
    }
  }
}
