import 'package:first_app/model/db/todo_item_data.dart';
import 'package:first_app/state_notifier/event_provider.dart';
import 'package:first_app/view/calendar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarEventList extends ConsumerStatefulWidget {
  const CalendarEventList({super.key});

  @override
  ConsumerState<CalendarEventList> createState() => CalendarEventListState();
}

class CalendarEventListState extends ConsumerState<CalendarEventList> {
  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    final todoProvider = ref.watch(todoDatabaseProvider.notifier);
    List<TodoItemData> todoItems = todoProvider.state.todoItems;

    List<Widget> tiles = buildTodoList(todoItems, todoProvider);

    return Scaffold(
      body: Container(
        color: ref.read(whiteColorProvider.notifier).state,
        child: (list.isEmpty)
            ? const Center(
                child: Text('予定がありません'),
              )
            : ListView(children: tiles),
      ),
    );
  }

  // 予定追加画面において、todoリストを作成するメソッド。
  List<Widget> buildTodoList(
      List<TodoItemData> todoItemList, TodoDatabaseNotifier db) {
    for (TodoItemData item in todoItemList) {
      Widget tile = Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 0,
            color: Colors.grey,
          ),
        )),
        child: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, "/EditingPage", arguments: item),
          child: ListTile(
            tileColor: ref.read(whiteColorProvider.notifier).state,
            leading: Column(
              children: [
                Text(item.startDate.toString()),
                Text(item.startDate.toString()),
              ],
            ),
            trailing: Title(
              color: Colors.black,
              child: Text(item.title),
            ),
          ),
        ),
      );
      list.add(tile);
    }
    return list;
  }
}
