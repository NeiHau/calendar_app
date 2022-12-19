import 'package:first_app/model/database/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/state_notifier/event_map_provider.dart';
import 'package:first_app/state_notifier/event_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final startDayProvider = StateProvider((ref) => DateTime.now());
final finishDayProvider = StateProvider((ref) => DateTime.now());

class EventAddingPage extends ConsumerStatefulWidget {
  const EventAddingPage({
    super.key,
    this.event,
    required this.currentDate,
  });

  final Event? event;
  final DateTime currentDate;

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
  static var uuid = const Uuid(); // idを取得
  Event temp = Event(
      id: uuid.v1(),
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      title: '',
      description: '',
      isAllDay: false); //frezzedで格納した値をインスタンス化

  @override
  void initState() {
    if (widget.event == null) {
      startDate = widget.currentDate;
      endDate = startDate.add(const Duration(hours: 2));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              buildTitle(), // タイトルを入力
              sizedBox(), // 余白を生成する
              selectShujitsuDay(), // 開始日・終了日を選択
              buildDescription(), // コメントを入力
            ],
          ),
        ),
      ),
    );
  }

  // 「保存」ボタンを表示させるためのメソッド。
  List<Widget> buildEditingActions() => [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
          child: TextButton(
            onPressed: (temp.title == '' || temp.description == '')
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
                    todoProvider.writeData(data);

                    final saveProvider = ref.watch(eventStateProvider.notifier);
                    saveProvider.readDataMap();

                    //Navigator.pushNamed(context, '/home');
                    Navigator.popUntil(
                        context, (Route<dynamic> route) => route.isFirst);
                  },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: const Text('保存'),
          ),
        ),
      ];

  // タイトルに入力をするためのメソッド。
  Widget buildTitle() => Card(
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
            child: TextFormField(
              onChanged: (value) {
                temp = temp.copyWith(title: value);
                setState(() {});
              },
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: UnderlineInputBorder(),
                  hintText: 'タイトルを入力してください'),
            )),
      );

  // 開始日、終了日を入力するためのメソッド。
  Card selectShujitsuDay() {
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
                  initialDateTime: DateTime(
                    widget.currentDate.year,
                    widget.currentDate.month,
                    widget.currentDate.day,
                    widget.currentDate.hour,
                  ),
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(startDate: value);
                    setState(() {
                      startDate = value;
                    });
                  },
                  use24hFormat: true,
                  mode: isAllDay
                      ? CupertinoDatePickerMode.date
                      : CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
                ));
              },
            ),
          ),
          ListTile(
            title: const Text('終了'),
            trailing: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text(isAllDay
                  ? DateFormat('yyyy-MM-dd').format(endDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(endDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  initialDateTime: DateTime(
                    endDate.year,
                    endDate.month,
                    endDate.day,
                    endDate.hour,
                  ),
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(endDate: value);
                    setState(() {
                      endDate = value;
                    });
                  },
                  use24hFormat: true,
                  mode: isAllDay
                      ? CupertinoDatePickerMode.date
                      : CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
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
        temp = temp.copyWith(isAllDay: value);
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
            setState(() {});
          },
          style: const TextStyle(fontSize: 12),
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: UnderlineInputBorder(),
            hintText: 'コメントを入力してください',
          ),
          maxLines: 8,
        ),
      ),
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

                              final isEqual = endDate.microsecondsSinceEpoch ==
                                  startDate.millisecondsSinceEpoch;

                              if (isAllDay) {
                                if (isEndTimeBefore || isEqual) {
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

  // 余白を作るためのメソッド。
  Widget sizedBox() {
    return const SizedBox(height: 25, width: 10);
  }
}
