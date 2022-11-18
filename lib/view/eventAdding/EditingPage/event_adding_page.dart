import 'package:first_app/model/db/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/state_notifier/event_provider.dart';
import 'package:first_app/state_notifier/event_map_provider.dart';
import 'package:first_app/view/calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final startDayProvider = StateProvider((ref) => DateTime.now());
final finishDayProvider = StateProvider((ref) => DateTime.now());

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
  static var uuid = const Uuid(); // idを取得
  Event temp = Event(
      id: uuid.v1(),
      startDate: DateTime.now(),
      endDate: DateTime.now()); //frezzedで格納した値をインスタンス化

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
              buildTitle(), // タイトル
              sizedBox(), // 余白
              selectShujitsuDay(), // 開始日・終了日
              buildDescription(), // コメント
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
            onPressed: () {
              TodoItemData data = TodoItemData(
                id: uuid.v1(),
                title: temp.title,
                description: temp.description,
                startDate: temp.startDate,
                endDate: temp.endDate,
                shujitsuBool: temp.isAllDay,
              );
              // 'todoprovider'でProviderのメソッドや値を取得。
              final todoProvider = ref.watch(todoDatabaseProvider.notifier);
              todoProvider.writeData(data);

              final saveProvider = ref.watch(eventStateProvider.notifier);
              saveProvider.readDataMap();

              Navigator.pushNamed(context, "/home");
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    ref.read(whiteColorProvider))),
            child: const Text('保存'),
          ),
        )
      ];

  // タイトルに入力をするためのメソッド。
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
                  hintText: 'タイトルを入力してください'),
              onFieldSubmitted: (value) {
                temp = temp.copyWith(title: value);
              }),
        ),
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
                  ? DateFormat('yyyy-MM-dd').format(endDate)
                  : DateFormat('yyyy-MM-dd HH:mm').format(endDate)),
              onPressed: () {
                cupertinoDatePicker(CupertinoDatePicker(
                  onDateTimeChanged: (value) {
                    temp = temp.copyWith(endDate: value);
                    setState(() {
                      endDate = value;
                    });
                  },
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minuteInterval: 15,
                  initialDateTime: DateTime(
                    endDate.year,
                    endDate.month,
                    endDate.day,
                    endDate.hour,
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

  // 余白を作るためのメソッド。
  Widget sizedBox() {
    return const SizedBox(height: 25, width: 10);
  }
}
