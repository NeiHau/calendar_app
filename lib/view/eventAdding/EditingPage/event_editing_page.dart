import 'package:first_app/model/database/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/model/freezed/event_list.dart';
import 'package:first_app/state_notifier/event_map_provider.dart';
import 'package:first_app/state_notifier/event_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final startDayProvider = StateProvider((ref) => DateTime.now());
final finishDayProvider = StateProvider((ref) => DateTime.now());

class EventEditingPage extends ConsumerStatefulWidget {
  const EventEditingPage({this.event, super.key});

  final Event? event;

  @override
  ConsumerState<EventEditingPage> createState() => EventEditingPageState();
}

class EventEditingPageState extends ConsumerState<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  late FocusNode addTaskFocusNode;
  bool isAllDay = false; // 終日かどうかを判定。
  static var uuid = const Uuid(); // idを取得

  Event temp =
      Event(id: uuid.v1(), startDate: DateTime.now(), endDate: DateTime.now());
  TodoEventList updated =
      TodoEventList(isUpdated: false); // 編集画面で入力が更新されたかどうかを判定する際に用いる変数。

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoDatabaseProvider);
    List<Event> todoItems = state.todoItems;

    // 追加画面で入力したデータを編集画面に渡す際に用いる変数。
    final Event args = ModalRoute.of(context)?.settings.arguments as Event;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Center(
          child: Text('予定の編集'),
        ),
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(args),
              sizedBox(),
              selectShujitsuDay(args),
              buildDescription(args),
              sizedBox(),
              deleteSchedule(todoItems, args),
            ],
          ),
        ),
      ),
    );
  }

  // 「保存」ボタンを作成するメソッド
  List<Widget> buildEditingActions() => [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
          child: TextButton(
            onPressed: (updated.isUpdated == false)
                ? null
                : () {
                    TodoItemData data = TodoItemData(
                      id: temp.id,
                      title: temp.title,
                      description: temp.description,
                      startDate: temp.startDate,
                      endDate: temp.endDate,
                      shujitsuBool: temp.isAllDay,
                    );
                    // 'todoprovider'でProviderのメソッドや値を取得。
                    final todoProvider =
                        ref.watch(todoDatabaseProvider.notifier);
                    todoProvider.updateData(data);

                    /*
                    final saveProvider = ref.watch(eventStateProvider.notifier);
                    saveProvider.readDataMap();
                    */

                    Navigator.of(context).pop();
                  },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: const Text('保存'),
          ),
        )
      ];

  // タイトルを入力するメソッド
  Widget buildTitle(Event data) => Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
          child: TextFormField(
            initialValue: data.title,
            onChanged: (value) {
              temp = data.copyWith(title: value);
              setState(() {
                updated = updated.copyWith(isUpdated: true);
              });
              print(updated);
            },
            style: const TextStyle(fontSize: 12),
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: UnderlineInputBorder(),
              hintText: 'タイトルを入力してください',
            ),
          ),
        ),
      );

  // 開始日と終了日を選択するメソッド
  Card selectShujitsuDay(Event data) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('終日'),
            trailing: createSwitch(0),
          ),
          ListTile(
            title: const Text('開始'),
            trailing: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text((isAllDay == true)
                  ? DateFormat('yyyy-MM-dd').format(data.startDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(data.startDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  onDateTimeChanged: (value) {
                    temp = data.copyWith(startDate: value);
                    setState(() {
                      updated = updated.copyWith(isUpdated: true);
                    });
                  },
                  mode: isAllDay
                      ? CupertinoDatePickerMode.date
                      : CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
                  initialDateTime: DateTime(
                    data.startDate.year,
                    data.startDate.month,
                    data.startDate.day,
                    data.startDate.hour,
                  ),
                ));
              },
            ),
          ),
          ListTile(
            title: const Text('終了'),
            trailing: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text((isAllDay == true)
                  ? DateFormat('yyyy-MM-dd').format(data.endDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(data.endDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  onDateTimeChanged: (value) {
                    temp = data.copyWith(endDate: value);
                    setState(() {
                      updated = updated.copyWith(isUpdated: true);
                    });
                  },
                  mode: isAllDay
                      ? CupertinoDatePickerMode.date
                      : CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
                  initialDateTime: DateTime(
                    data.endDate.year,
                    data.endDate.month,
                    data.endDate.day,
                    data.endDate.hour,
                  ),
                ));
              },
            ),
          )
        ],
      ),
    );
  }

  // 終日スイッチ
  Switch createSwitch(int index) {
    return Switch(
      value: temp.isAllDay,
      onChanged: (value) {
        setState(() {
          isAllDay = value;
          updated = updated.copyWith(isUpdated: true);
        });
        temp = temp.copyWith(isAllDay: value);
      },
    );
  }

  // コメント入力するフォームを作成するメソッド
  Widget buildDescription(Event data) {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
        child: TextFormField(
          initialValue: data.description,
          style: const TextStyle(fontSize: 12),
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: UnderlineInputBorder(),
            hintText: '入力してください',
          ),
          maxLines: 8,
          onChanged: (value) {
            temp = data.copyWith(description: value);
            setState(() {
              updated = updated.copyWith(isUpdated: true);
            });
          },
        ),
      ),
    );
  }

  // 予定を削除するメソッド
  Widget deleteSchedule(List<Event> todoItemList, Event data) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        fixedSize: const Size(450, 50), //(横、高さ)
      ),
      onPressed: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: const Text('編集を破棄'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("予定の削除"),
                          content: const Text('本当にこの日の予定を削除しますか？'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "キャンセル",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                final todoProvider =
                                    ref.watch(todoDatabaseProvider.notifier);
                                todoProvider.deleteData(data);

                                /*
                                final deleteProvider =
                                    ref.watch(eventStateProvider.notifier);
                                deleteProvider.readDataMap();
                                */

                                Navigator.pushNamed(context, "/home");
                              },
                              child: const Text('削除'),
                            ),
                          ],
                        );
                      },
                    ),
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text('キャンセル'),
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
              ),
            );
          },
        );
      },
      child: const Text('この予定を削除'),
    );
  }

  // 開始日と終了日を選択する際に用いるDatePickerを表示させるメソッド。
  Future<void> cupertinoDatePicker(Widget child) async {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => Container(
              height: 280,
              padding: const EdgeInsets.only(top: 6),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('キャンセル')),
                        TextButton(
                            onPressed: () {
                              final isEndTimeBefore =
                                  endDate.isBefore(startDate);
                              final isStartTimeAfter =
                                  startDate.isAfter(endDate);
                              final isEqual = endDate.microsecondsSinceEpoch ==
                                  startDate.millisecondsSinceEpoch;

                              if (isAllDay) {
                                if (isEndTimeBefore || isEqual) {
                                  setState(() {
                                    endDate = startDate;
                                  });
                                } else if (isStartTimeAfter) {
                                  setState(() {
                                    endDate = startDate;
                                  });
                                }
                              } else {
                                if (isEndTimeBefore || isEqual) {
                                  setState(() {
                                    endDate =
                                        startDate.add(const Duration(hours: 1));
                                  });
                                }
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('完了'))
                      ],
                    ),
                  ),
                  Expanded(child: SafeArea(top: false, child: child)),
                ],
              ),
            ));
  }

  // 余白を作りたい時に用いるメソッド
  Widget sizedBox() {
    return const SizedBox(
      height: 25,
      width: 10,
    );
  }
}
