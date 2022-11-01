import 'package:first_app/view/calendar.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime now = DateTime.now();
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
              onPageChanged: (value) {
                getNextMonth();
              },
            ),
          ),
        ],
      ),
    );
  }

  getNextMonth() {
    if (now.month == 12) {
      now = DateTime(now.year + 1, 1);
    } else {
      now = DateTime(now.year, now.month + 1);
    }
    return now;
  }

  getPrevMonth() {
    if (now.month == 1) {
      now = DateTime(now.year - 1, 12);
    } else {
      now = DateTime(now.year, now.month - 1);
    }
    return now;
  }
}
