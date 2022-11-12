import 'package:first_app/model/db/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/model/freezed/event_state_data.dart';
import 'package:first_app/state_notifier/add_event_state_notifier.dart';
import 'package:first_app/view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final startDayProvider = StateProvider((ref) => DateTime.now());
final finishDayProvider = StateProvider((ref) => DateTime.now());

//final tempProvider = StateProvider(((ref) => Event()));

class EventAddingPage extends ConsumerStatefulWidget {
  const EventAddingPage({super.key, this.event});

  final Event? event;

  @override
  ConsumerState<EventAddingPage> createState() => EventAddingPageState();
}

class EventAddingPageState extends ConsumerState<EventAddingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  late FocusNode addTaskFocusNode;
  bool isAllDay = false;

  Event temp = Event(); //frezzedで格納した値をインスタンス化
  //TodoStateData

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      startDate = DateTime.now();
      endDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoState = ref.watch(todoDatabaseProvider);
    final todoProvider = ref.watch(todoDatabaseProvider.notifier);
    List<TodoItemData> todoItems = todoProvider.state.todoItems;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Center(
          child: Text('予定の追加'),
        ),
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
              sizedBox(), // 余白を入れてあげる。
              selectShujitsuStartDay(),
              buildDescription(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildEditingActions() => [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalendarPage()));

              final todoProvider = ref.watch(todoDatabaseProvider.notifier);
              todoProvider.writeData(temp);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: const Text('保存'),
          ),
        )
      ];

  Widget buildTitle() => Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
          child: TextFormField(
              onChanged: (value) {
                temp = temp.copyWith(title: value);
              },
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: UnderlineInputBorder(),
                hintText: 'タイトルを入力してください',
              ),
              onFieldSubmitted: (value) {
                temp = temp.copyWith(title: value);
              }),
        ),
      );

  Card selectShujitsuStartDay() {
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
              child: Text(isAllDay
                  ? DateFormat('yyyy-MM-dd').format(startDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(startDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(startDate: value);
                    setState(() {
                      startDate = value;
                    });
                  },
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
                  initialDateTime: DateTime(
                    startDate.year,
                    startDate.month,
                    startDate.day,
                    startDate.hour,
                    //startDate.minute, //ここで分を計算したい。 新しい変数をここで宣言してあげる。
                  ),
                ));
              },
            ),
          ),
          ListTile(
            title: const Text('終了'),
            trailing: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text(isAllDay
                  ? DateFormat('yyyy-MM-dd').format(startDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(startDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(endDate: value);
                    setState(() {
                      startDate = value;
                    });
                  },
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
                  initialDateTime: DateTime(
                    endDate.year,
                    endDate.month,
                    endDate.day,
                    endDate.hour,
                    //startDate.minute,  //ここも同様。新しい変数をここで宣言してあげる。
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
      value: isAllDay,
      onChanged: (value) {
        setState(() {
          isAllDay = value;
        });
      },
    );
  }

  // コメントを入力
  Widget buildDescription() {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
        child: TextFormField(
          onChanged: (value) {
            temp = temp.copyWith(description: value);
          },
          style: const TextStyle(fontSize: 12),
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: UnderlineInputBorder(),
            hintText: 'コメントを入力してください',
          ),
          maxLines: 8,
          onFieldSubmitted: (value) {
            temp = temp.copyWith(description: value);
          },
        ),
      ),
    );
  }

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
                                  startDate.isBefore(startDate);
                              final isEqual =
                                  startDate.microsecondsSinceEpoch ==
                                      startDate.millisecondsSinceEpoch;

                              if (isAllDay) {
                                if (isEndTimeBefore || isEqual) {
                                  setState(() {
                                    startDate = startDate;
                                  });
                                }
                              } else {
                                if (isEndTimeBefore || isEqual) {
                                  setState(() {
                                    startDate =
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

  Widget sizedBox() {
    return const SizedBox(
      height: 25,
      width: 10,
    );
  }
}
