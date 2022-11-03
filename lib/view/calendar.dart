import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

final weekDayProvider = StateProvider(((ref) => 7));
final monthDurationProvider = StateProvider(((ref) => 0));
final nowProvider = StateProvider(((ref) => DateTime.now()));

class Calendar extends ConsumerStatefulWidget {
  final Color? color;

  const Calendar({this.color, Key? key}) : super(key: key);

  @override
  ConsumerState<Calendar> createState() => CalendarState();
}

class CalendarState extends ConsumerState<Calendar> {
  final List<String> _weekName = ['月', '火', '水', '木', '金', '土', '日'];
  late DateTime selectedDate;

  @override
  void initState() {
    var now = ref.read(nowProvider.notifier).state;
    selectedDate = now;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentMonth(),
        dayOfWeek(ref),
        Expanded(
          child: calendar(ref),
        ),
      ],
    );
  }

  Container currentMonth() {
    var now = ref.read(nowProvider.notifier).state;
    var monthDuration = ref.read(monthDurationProvider.notifier).state;
    return Container(
      color: Colors.white,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            child: ElevatedButton(
              onPressed: () {
                selectedDate = now; // '今日'と書かれたボタンを押すと、今日の日付に移行させたい。
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text('今日'),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                child: Text(
                  DateFormat('yyyy年M月').format(
                    DateTime(now.year, now.month + monthDuration, 1),
                  ),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 75, 5),
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectDate(context: context, locale: 'ja', ref: ref);
                  });
                },
              ),
            ],
          ),
          const SizedBox(),
        ],
      ),
    );
  }

  Widget dayOfWeek(WidgetRef ref) {
    var weekDay = ref.read(weekDayProvider.notifier).state;
    List<Widget> weekList = [];
    int weekIndex = weekDay; //初期値
    int counter = 0;
    while (counter < 7) {
      weekList.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _weekName[weekIndex % 7],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12.0, color: Colors.black),
              ),
            ),
          ),
        ),
      );
      weekIndex++;
      counter++;
    }
    return Row(
      children: weekList,
    );
  }

  Widget calendar(WidgetRef ref) {
    var now = ref.read(nowProvider.notifier).state;
    var monthDuration = ref.read(monthDurationProvider.notifier).state;
    var weekDay = ref.read(weekDayProvider.notifier).state + 1;
    List<Widget> list = [];

    DateTime firstDayOfTheMonth =
        DateTime(now.year, now.month + monthDuration, 1);
    int monthLastNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month + 1, 1)
            .add(const Duration(days: -1))
            .day;
    List<Widget> listCache = [];
    for (int i = 1; i <= monthLastNumber; i++) {
      listCache.add(
        Expanded(
          child: buildCalendarItem(i,
              DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)),
        ),
      );

      if (DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)
                  .weekday ==
              newLineNumber(startNumber: weekDay) ||
          i == monthLastNumber) {
        int repeatNumber = 7 - listCache.length;
        for (int j = 0; j < repeatNumber; j++) {
          if (DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)
                  .day <=
              7) {
            listCache.insert(
              0,
              Expanded(
                child: Container(),
              ),
            );
          } else {
            listCache.add(
              Expanded(
                child: Container(),
              ),
            );
          }
        }

        list.add(
          Row(
            children: listCache,
          ),
        );
        listCache = [];
      }
    }

    return Column(
      children: list,
    );
  }

  int newLineNumber({required int startNumber}) {
    if (startNumber == 1) return 7;
    return startNumber - 1;
  }

  Widget buildCalendarItem(int i, DateTime cacheDate) {
    bool isToday = (selectedDate.difference(cacheDate).inDays == 0) &&
        (selectedDate.day == cacheDate.day);
    if (isToday) {
      return Container(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (isToday) ? Colors.blue : Colors.transparent,
          ),
          child: Text(
            '$i',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.0,
                color: (isToday) ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 30,
          height: 30,
          child: Text(
            '$i',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
      ),
      onTap: () {
        selectedDate = cacheDate;
        setState(() {});
      },
    );
  }

  Color dateColor(DateTime day) {
    const defaultDateColor = Colors.black87;
    if (day.weekday == DateTime.sunday) {
      return Colors.red;
    }
    if (day.weekday == DateTime.saturday) {
      return Colors.blue[600]!;
    }
    return defaultDateColor;
  }

  selectDate(
      {required BuildContext context,
      String? locale,
      required WidgetRef ref}) async {
    var now = ref.read(nowProvider.notifier).state;
    final localeObj = locale != null ? Locale(locale) : null;
    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 100),
      locale: localeObj,
    );

    if (selectedDate == null) return;

    setState(() {
      now = selectedDate;
    });
  }
}
