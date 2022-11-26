import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/state_notifier/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarEventList extends ConsumerStatefulWidget {
  const CalendarEventList({super.key});

  @override
  ConsumerState<CalendarEventList> createState() => CalendarEventListState();
}

class CalendarEventListState extends ConsumerState<CalendarEventList> {
  List<Widget> list = []; // １日から最終日を格納するリスト。

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoDatabaseProvider); // stateとnotifierは別で管理。
    List<Event> todoItems = state.todoItems;

    // 全てのtileを格納するリスト
    List<Widget> tiles = buildTodoList(todoItems);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: (list.isEmpty)
            ? const Center(
                child: Text('予定がありません'),
              )
            : ListView(children: tiles),
      ),
    );
  }

  // 予定追加画面において、todoリストを作成するメソッド。
  List<Widget> buildTodoList(List<Event> todoItemList) {
    for (Event item in todoItemList) {
      Widget tile = Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 0,
            color: Colors.grey[200]!,
          ),
        )),
        child: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, "/EditingPage", arguments: item),
          child: ListTile(
            tileColor: Colors.white,
            leading: (item.isAllDay == true)
                ? const Text('終日')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateFormat('HH:mm').format(item.startDate)),
                      Text(DateFormat('HH:mm').format(item.endDate)),
                    ],
                  ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blue,
                  child: const VerticalDivider(
                    color: Colors.blue,
                    thickness: 1,
                    indent: 50,
                    width: 4,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Title(
                  color: Colors.black,
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
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
