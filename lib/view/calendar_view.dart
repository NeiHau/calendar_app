import 'package:first_app/view/calendar.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: PageController(initialPage: 1500),
              itemBuilder: (context, index) {
                return const Calendar(weekDay: 1); // 何曜日からはじまるか（月曜日は1,日曜日は7),
              },
            ),
          ),
        ],
      ),
    );
  }
}
