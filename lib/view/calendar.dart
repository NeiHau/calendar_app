import 'package:first_app/component/color.dart';
import 'package:first_app/view/calendar_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

final weekDayProvider = StateProvider(((ref) => 7));
final foucusedDayProvider = StateProvider(((ref) => DateTime.now()));
final cacheDateProvider = StateProvider(((ref) => DateTime.now()));
final todayProvider = StateProvider(((ref) => DateTime.now()));

class Calendar extends ConsumerStatefulWidget {
  final Color? color;
  final DateTime? now;
  final DateTime? weekDay;
  final PageController calendarController;

  const Calendar(this.calendarController,
      {this.color, this.now, this.weekDay, Key? key})
      : super(key: key);

  @override
  ConsumerState<Calendar> createState() => CalendarState();
}

class CalendarState extends ConsumerState<Calendar> {
  final List<String> _weekName = ['月', '火', '水', '木', '金', '土', '日'];
  late DateTime selectedDate;
  final int _monthDuration = 0;
  final firstDay = DateTime(1970);
  late int prevPage;

  @override
  void initState() {
    selectedDate = ref.read(foucusedDayProvider.notifier).state;
    final initialPageCount = getPageCount(firstDay, selectedDate);
    prevPage = initialPageCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentMonth(ref),
        dayOfWeek(ref),
        Expanded(child: calendar(ref)),
      ],
    );
  }

  // 今月のカレンダー画面で表示させたい機能('今日ボタン','年月','MonthYearPicker')を含むメソッド
  Container currentMonth(WidgetRef ref) {
    return Container(
      color: Colors.white,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder()),
                onPressed: () {
                  // なぜか２回押さないと、今日の日付に遷移しない。１回で遷移させたい。
                  // １回タップすると、月の最初の日に遷移。
                  widget.calendarController.animateToPage(
                      widget.calendarController.initialPage,
                      duration: const Duration(milliseconds: 2),
                      curve: Curves.ease);
                  setState(() {
                    selectedDate = DateTime.now();
                  });
                },
                child: const Text('今日')),
          ),
          Row(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 13, 5),
              child: Text(
                  DateFormat('yyyy年M月').format(DateTime(
                      ref.read(foucusedDayProvider).year,
                      ref.read(foucusedDayProvider).month + _monthDuration,
                      1)),
                  style: const TextStyle(fontSize: 20.0, color: Colors.black)),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 65, 5),
                child: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                setState(() {});
              },
            )
          ]),
          const SizedBox(),
        ],
      ),
    );
  }

  // カレンダーの曜日を表示させるメソッド
  Widget dayOfWeek(WidgetRef ref) {
    List<Widget> weekList = [];
    int weekIndex = ref.read(weekDayProvider); //初期値
    int counter = 0;
    while (counter < 7) {
      weekList.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: ref.read(greyProvider)),
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

  // カレンダーの日にちを作成するメソッド
  Widget calendar(WidgetRef ref) {
    List<Widget> list = []; // カレンダーの日数全てを含むリスト。1日〜最終日まで。

    // 月の最初の日。
    DateTime firstDayOfTheMonth = DateTime(ref.watch(foucusedDayProvider).year,
        ref.watch(foucusedDayProvider).month + _monthDuration, 1);
    // 月の最終日。
    int monthLastNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month + 1, 1)
            .add(const Duration(days: -1))
            .day;
    // 今月のカレンダーの第一週の空いている部分を埋める際に用いる、前月の最後の週の日にちを求める変数。
    int previousMonthLastNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, 1)
            .add(const Duration(days: -1))
            .day;
    // 今月のカレンダーの最後の週の空いている部分を埋める際に用いる、来月の第一週目の日にちを求める変数。
    int nextMonthFirstNumber =
        DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month + 1, 1).day;
    List<Widget> listCache = [];

    for (int i = 1; i <= monthLastNumber; i++) {
      listCache.add(
        Expanded(
          child: buildCalendarItem(
              i,
              DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i),
              ref),
        ),
      );
      if (DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)
                  .weekday ==
              newLineNumber(startNumber: ref.read(weekDayProvider) + 1) ||
          i == monthLastNumber) {
        int repeatNumber = 7 - listCache.length;

        for (int j = 0; j < repeatNumber; j++) {
          if (DateTime(firstDayOfTheMonth.year, firstDayOfTheMonth.month, i)
                  .day <=
              7) {
            listCache.insert(
              0,
              Expanded(
                child: buildCalendarItem(
                    previousMonthLastNumber - j,
                    DateTime(
                        firstDayOfTheMonth.year,
                        firstDayOfTheMonth.month - 1,
                        previousMonthLastNumber - j),
                    ref),
              ),
            );
          } else {
            listCache.add(
              Expanded(
                child: buildCalendarItem(
                    nextMonthFirstNumber + j,
                    DateTime(firstDayOfTheMonth.year,
                        firstDayOfTheMonth.month + 1, nextMonthFirstNumber + j),
                    ref),
              ),
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

  // 次の週に移行する際に用いるメソッド。例: 第一週目 → 第二週目。
  int newLineNumber({required int startNumber}) {
    if (startNumber == 1) return 7;
    return startNumber - 1;
  }

  // 1. 今日を青い丸で囲む。
  // 2. 日付をタップした際に予定を追加する画面に移行する。
  // 上記の二点を以下のメソッド内で行う。
  Widget buildCalendarItem(int i, DateTime cacheDate, WidgetRef ref) {
    final focusedDay = ref.read(foucusedDayProvider);
    bool isToday = (selectedDate.difference(cacheDate).inDays == 0) &&
        (selectedDate.day == cacheDate.day);
    bool isOutsideDay = (focusedDay.month != cacheDate.month);

    if (isToday) {
      return Container(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
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

    if (isOutsideDay) {
      return Container(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
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
                  color: Colors.blueGrey[100],
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
        createTask();
      },
    );
  }

  // 「土」と「日」の色を変更するメソッド。「土」は青、「日」は赤。
  Color _textDayColor(DateTime day) {
    const defaultTextColor = Colors.black87;

    if (day.weekday == DateTime.sunday) {
      return ref.read(redProvider);
    }
    if (day.weekday == DateTime.saturday) {
      return Colors.blue[600]!;
    }
    return defaultTextColor;
  }

  // カレンダーの日付が土曜日なら青色、日曜日なら赤色に変更するメソッド。
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

  // MonthYearPickerを表示させるメソッド。
  selectDate({required BuildContext context, String? locale}) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selectedDate = await showMonthYearPicker(
        context: context,
        initialDate: ref.read(foucusedDayProvider),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 100),
        locale: localeObj);

    if (selectedDate == null) return;

    setState(() {
      ref.read(foucusedDayProvider.notifier).state = selectedDate;
    });
  }

  // 日付をタップした際に表示させる予定追加画面のメソッド。
  void createTask() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CalendarListDialog();
        });
  }
}
