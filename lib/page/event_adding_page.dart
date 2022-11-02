import 'package:first_app/model/event.dart';
import 'package:flutter/material.dart';

class EventAddingPage extends StatefulWidget {
  EventAddingPage({super.key, this.event});

  final Event? event;

  @override
  State<EventAddingPage> createState() => _EventAddingPageState();
}

class _EventAddingPageState extends State<EventAddingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  late FocusNode addTaskFocusNode;

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
              buildTitle2(),
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

  Widget buildDescription() => Card(
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
}
