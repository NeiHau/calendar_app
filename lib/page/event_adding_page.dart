import 'package:first_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final startDayProvider = StateProvider((ref) => DateTime.now());
final finishDayProvider = StateProvider((ref) => DateTime.now());

class EventAddingPage extends ConsumerStatefulWidget {
  EventAddingPage({super.key, this.event});

  final Event? event;

  @override
  ConsumerState<EventAddingPage> createState() => EventAddingPageState();
}

class EventAddingPageState extends ConsumerState<EventAddingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  late FocusNode addTaskFocusNode;

  // （1） 選択済みの値を保存する変数
  final _switchValues = [false, false];

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
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
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
<<<<<<< HEAD
              buildTitle2(),
              buildDescription(),
=======
              //buildTitle2(),
              selectShujitsuStartDay(),
              buildDescription()
>>>>>>> aa287f8 (コミット)
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
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: const Text('保存'),
          ),
        )
      ];

  Widget buildTitle() => Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 7, 5, 5),
          child: TextFormField(
            style: const TextStyle(fontSize: 12),
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: UnderlineInputBorder(),
              hintText: 'タイトルを入力してください',
            ),
            onFieldSubmitted: (_) {},
          ),
        ),
      );

  /*
  Widget scheduleBuild() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return DatePickerAlertDialog();
            });
      },
      child: Container(
        height: 60,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),

              ],
            )),
      ),
    );
  }
  */

  /*
  Widget buildTitle2() => AlertDialog(
        title: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
          ),
        ),
        content: const SizedBox(
          height: 360,
          width: 350,
          child: Center(
            child: Text('予定がありません。'),
          ),
        ),
      );
  */

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
            title: const Text('終日'),
            trailing: createSwitch(0),
          ),
          ListTile(
            title: const Text('終日'),
            trailing: createSwitch(0),
          )
        ],
      ),
    );
  }

  Switch createSwitch(int index) {
    return Switch(
      // （3） 現在のOF/OFF状態
      value: _switchValues[index],
      // （4） 値が変わった時
      onChanged: (bool? value) {
        setState(() {
          _switchValues[index] = value!;
        });
      },
    );
  }

  Widget buildDescription() => Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 7, 5, 5),
          child: TextFormField(
            style: const TextStyle(fontSize: 12),
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: UnderlineInputBorder(),
              hintText: 'あなたの好きなセクシー女優を入力してください',
            ),
            onFieldSubmitted: (_) {},
          ),
        ),
      );

  /*
  bool stringTime(DateTime date, WidgetRef ref) {
    if
  }
  */
}
