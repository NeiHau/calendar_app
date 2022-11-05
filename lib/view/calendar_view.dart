import 'package:first_app/view/calendar.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
=======
import '../view/calendar.dart';
>>>>>>> aa287f8 (コミット)

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  //DateTime now = DateTime.now();
  String? newTask;
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
<<<<<<< HEAD
              controller: PageController(initialPage: 1500),
              onPageChanged: (value) {
                getNextMonth();
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      createTask();
                    },
                    child: const Calendar());
=======
              controller: PageController(initialPage: 1200),
              itemBuilder: (context, index) {
                return Calendar();
>>>>>>> aa287f8 (コミット)
              },
              onPageChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  getNextMonth() {
    var now = ref.read(nowProvider.notifier).state;
    if (now.month == 12) {
      now = DateTime(now.year + 1, 1);
    } else {
      now = DateTime(now.year, now.month + 1);
    }
    return now;
  }

  getPrevMonth() {
    var now = ref.read(nowProvider.notifier).state;
    if (now.month == 1) {
      now = DateTime(now.year - 1, 12);
    } else {
      now = DateTime(now.year, now.month - 1);
    }
    return now;
  }
<<<<<<< HEAD

  void createTask() {
    var now = ref.read(nowProvider.notifier).state;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('yyyy/MM/dd (EEE)', 'ja').format(
                        DateTime(now.year, now.month, now.day),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventAddingPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              content: const SizedBox(
                height: 360,
                width: 400,
                child: Center(
                  child: Text('予定がありません。'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
=======
>>>>>>> aa287f8 (コミット)
}
