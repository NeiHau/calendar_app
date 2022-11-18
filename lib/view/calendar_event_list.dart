import 'package:first_app/component/color.dart';
import 'package:first_app/model/db/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
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
  List<Widget> list = []; // １日から最終日を格納するリスト。

  @override
  Widget build(BuildContext context) {
    final todoProvider = ref.watch(todoDatabaseProvider.notifier);
    List<Event> todoItems = todoProvider.state.todoItems.cast<Event>();

    // tile全てを格納するリスト
    List<Widget> tiles = buildTodoList(todoItems, todoProvider);

    return Scaffold(
      body: Container(
        color: ref.read(whiteColorProvider),
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
      List<Event> todoItemList, TodoDatabaseNotifier db) {
    for (Event item in todoItemList) {
      bool isAllday = (item.isAllDay == false);
      Widget tile = Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 0,
            color: ref.read(greyProvider),
          ),
        )),
        child: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, "/EditingPage", arguments: item),
          child: ListTile(
            tileColor: ref.read(whiteColorProvider),

            // ここ分からない。
            leading: (isAllday)
                ? const Text('終日')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.startDate.hour.toString()),
                      Text(item.endDate.hour.toString()),
                    ],
                  ),
            title: Row(
              children: [
                const VerticalDivider(
                  color: Colors.blue,
                  thickness: 4,
                ),
                Title(
                  color: ref.read(blackProvider),
                  child: Text(
                    item.title,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      list.add(tile);
    }
    return list;
  }
}
