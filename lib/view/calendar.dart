import 'package:first_app/page/event_adding_page.dart';
import 'package:first_app/view/calendar_create_task.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

final weekDayProvider = StateProvider(((ref) => 7));
<<<<<<< HEAD
final monthDurationProvider = StateProvider(((ref) => 0));
final nowProvider = StateProvider(((ref) => DateTime.now()));

class Calendar extends ConsumerStatefulWidget {
  final Color? color;

  const Calendar({this.color, Key? key}) : super(key: key);
=======
final nowProvider = StateProvider(((ref) => DateTime.now()));

class Calendar extends ConsumerStatefulWidget {
  final Color? color;
  final DateTime? now;
  DateTime? weekDay;

  Calendar({this.color, this.now, this.weekDay, Key? key}) : super(key: key);
>>>>>>> aa287f8 (コミット)

  @override
  ConsumerState<Calendar> createState() => CalendarState();
}

class CalendarState extends ConsumerState<Calendar> {
  final List<String> _weekName = ['月', '火', '水', '木', '金', '土', '日'];
  late DateTime selectedDate;
<<<<<<< HEAD

  @override
  void initState() {
    var now = ref.read(nowProvider.notifier).state;
    selectedDate = now;
=======
  final int _monthDuration = 0;

  @override
  void initState() {
    selectedDate = ref.read(nowProvider.notifier).state;
>>>>>>> aa287f8 (コミット)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentMonth(),
        dayOfWeek(ref),
<<<<<<< HEAD
        Expanded(
          child: calendar(ref),
        ),
=======
        Expanded(child: calendar(ref)),
>>>>>>> aa287f8 (コミット)
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
<<<<<<< HEAD
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
=======
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder()),
                onPressed: () {
                  selectedDate = ref.read(nowProvider);
                },
                child: const Text('今日')),
          ),
          Row(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 13, 5),
              child: Text(
                DateFormat('yyyy年M月').format(DateTime(
                    ref.read(nowProvider).year,
                    ref.read(nowProvider).month + _monthDuration,
                    1)),
                style: const TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 65, 5),
                child: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: Colors.black,
                ),
>>>>>>> aa287f8 (コミット)
              ),
              onTap: () {
                setState(() {
                  selectDate(context: context, locale: 'ja');
                });
              },
            )
          ]),
          const SizedBox(),
        ],
      ),
    );
  }

  Widget dayOfWeek(WidgetRef ref) {
<<<<<<< HEAD
    var weekDay = ref.read(weekDayProvider.notifier).state;
    List<Widget> weekList = [];
    int weekIndex = weekDay; //初期値
=======
    List<Widget> weekList = [];
    int weekIndex = ref.read(weekDayProvider); //初期値
>>>>>>> aa287f8 (コミット)
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
                style: TextStyle(
                    fontSize: 12.0, color: _textWeekDayColor(weekIndex)),
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
<<<<<<< HEAD
    var now = ref.read(nowProvider.notifier).state;
    var monthDuration = ref.read(monthDurationProvider.notifier).state;
    var weekDay = ref.read(weekDayProvider.notifier).state + 1;
    List<Widget> list = [];

    DateTime firstDayOfTheMonth =
        DateTime(now.year, now.month + monthDuration, 1);
=======
    List<Widget> list = [];

    DateTime firstDayOfTheMonth = DateTime(ref.read(nowProvider).year,
        ref.read(nowProvider).month + _monthDuration, 1);
    int monthFirstNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, 1).day;
>>>>>>> aa287f8 (コミット)
    int monthLastNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month + 1, 1)
            .add(const Duration(days: -1))
            .day;
    List<Widget> listCache = [];

    //DateTime additionalDate = ;
    List<DateTime> additionalDates = [];

    for (int i = 1; i <= monthLastNumber; i++) {
      listCache.add(
        Expanded(
          child: buildCalendarItem(i,
              DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)),
        ),
      );

      if (DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)
                  .weekday ==
<<<<<<< HEAD
              newLineNumber(startNumber: weekDay) ||
=======
              newLineNumber(startNumber: ref.read(weekDayProvider) + 1) ||
>>>>>>> aa287f8 (コミット)
          i == monthLastNumber) {
        int repeatNumber = 7 - listCache.length;
        for (int j = 0; j < repeatNumber; j++) {
          if (DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)
                  .day <=
              7) {
            listCache.insert(
              0,
              Expanded(child: Container()),
            );
          } else {
            listCache.add(
              Expanded(child: Container()),
            );
          }
        }

        list.add(Row(
          children: listCache,
        ));
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
          child: GestureDetector(
            onTap: () {
              createTask();
            },
            child: Text(
              '$i',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.0,
                  color: (isToday) ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
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
            style: TextStyle(
              fontSize: 14.0,
              color: _textDayColor(cacheDate),
            ),
          ),
        ),
      ),
      onTap: () {
<<<<<<< HEAD
        selectedDate = cacheDate;
=======
        createTask();
>>>>>>> aa287f8 (コミット)
        setState(() {});
      },
    );
  }

  Color _textDayColor(DateTime day) {
    const defaultTextColor = Colors.black87;

    if (day.weekday == DateTime.sunday) {
      return Colors.red;
    }
    if (day.weekday == DateTime.saturday) {
      return Colors.blue[600]!;
    }
    return defaultTextColor;
  }

  Color _textWeekDayColor(int weekIndex) {
    const defaultTextColor = Colors.black87;

    if (weekIndex == 13) {
      return Colors.red;
    }
    if (weekIndex == 12) {
      return Colors.blue[600]!;
    }
    return defaultTextColor;
  }

  selectDate(
      {required BuildContext context,
      String? locale,
      required WidgetRef ref}) async {
    var now = ref.read(nowProvider.notifier).state;
    final localeObj = locale != null ? Locale(locale) : null;
    final selectedDate = await showMonthYearPicker(
<<<<<<< HEAD
      context: context,
      initialDate: now,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 100),
      locale: localeObj,
    );
=======
        context: context,
        initialDate: ref.read(nowProvider),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 100),
        locale: localeObj);
>>>>>>> aa287f8 (コミット)

    if (selectedDate == null) return;

    setState(() {
<<<<<<< HEAD
      now = selectedDate;
=======
      ref.read(nowProvider.notifier).state = selectedDate;
>>>>>>> aa287f8 (コミット)
    });
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
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
                          DateTime(
                              ref.read(nowProvider).year,
                              ref.read(nowProvider).month,
                              ref.read(nowProvider).day),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventAddingPage()));
                          },
                          icon: const Icon(Icons.add, color: Colors.blue)),
                    ]),
              ),
              content: const SizedBox(
                  height: 360,
                  width: 400,
                  child: Center(child: Text('予定がありません。'))),
            ),
          ],
        );
      },
    );
  }
}
