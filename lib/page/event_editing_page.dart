/*

import 'package:first_app/model/event.dart';
import 'package:flutter/material.dart';

class EventEditingPage extends StatefulWidget {
  const EventEditingPage({super.key, this.event});

  final Event? event;

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

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
              //buildTitle(),
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

  /*
  Widget buildTitle() => TextFormField(
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'タイトルを入力してください',
        ),
        onFieldSubmitted: (_) {},
      );
  */
}
*/