import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class Calendar extends StatefulWidget {
  final int weekDay;
  final Color? color;

  const Calendar({this.weekDay = 7, this.color, Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final List<String> _weekName = ['月', '火', '水', '木', '金', '土', '日'];
  late DateTime selectedDate;
  DateTime _now = DateTime.now();
  final int _monthDuration = 0;

  @override
  void initState() {
    super.initState();
    selectedDate = _now;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentMonth(),
        dayOfWeek(),
        Expanded(
          child: calendar(),
        ),
      ],
    );
  }

  Container currentMonth() {
    return Container(
      color: Colors.white,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          OutlinedButton(
            onPressed: () {
              selectedDate = _now; // '今日'と書かれたボタンを押すと、今日の日付に移行させたい。
            },
            child: const Text('今日'),
          ),
          Row(
            children: [
              Text(
                DateFormat('yyyy年M月').format(
                  DateTime(_now.year, _now.month + _monthDuration, 1),
                ),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: Colors.black,
                ),
                onTap: () {
                  setState(() {
                    selectDate(context: context, locale: 'ja');
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

  Widget dayOfWeek() {
    List<Widget> weekList = [];
    int weekIndex = widget.weekDay - 1; //初期値-1
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

  Widget calendar() {
    List<Widget> list = [];

    DateTime firstDayOfTheMonth =
        DateTime(_now.year, _now.month + _monthDuration, 1);
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
              newLineNumber(startNumber: widget.weekDay) ||
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
            color: (isToday)
                ? widget.color ?? Theme.of(context).primaryColor
                : Colors.transparent,
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
        //decoration: BoxDecoration(border: buildBorder()),
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
        //print('${DateFormat('yyyy年M月d日').format(cacheDate)}が選択されました');
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

  selectDate({required BuildContext context, String? locale}) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: _now,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 100),
      locale: localeObj,
    );

    if (selectedDate == null) return;

    setState(() {
      _now = selectedDate;
    });
  }
}
