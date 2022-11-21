import 'package:first_app/model/database/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/model/freezed/event_state_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventStateProvider =
    StateNotifierProvider.family<EventStateNotifier, TodoStateData, Event>(
        (ref, temp) => EventStateNotifier(ref, temp));

class EventStateNotifier extends StateNotifier<TodoStateData> {
  EventStateNotifier(this.ref, this.temp) : super(TodoStateData());

  final Ref ref;
  MyDatabase database = MyDatabase();
  final Event temp;

  Future readDataMap() async {
    final eventsAll = await database.readTodoData(temp.startDate);

    state = state.copyWith(todoItemsMap: {});
    final Map<DateTime, List<Event>> dataMap = {};

    final List<Event> todoList = [];

    for (int i = 0; i < eventsAll.length; i++) {
      todoList.add(
        Event(
            id: eventsAll[i].id,
            title: eventsAll[i].title,
            description: eventsAll[i].description,
            startDate: eventsAll[i].startDate,
            endDate: eventsAll[i].endDate,
            isAllDay: eventsAll[i].shujitsuBool),
      );
    }

    print(todoList);

    for (final e in todoList) {
      final startDay =
          DateTime(e.startDate.year, e.startDate.month, e.startDate.day);
      final endDay = DateTime(e.endDate.year, e.endDate.month, e.endDate.day);

      var difference = endDay.difference(startDay).inDays;

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
