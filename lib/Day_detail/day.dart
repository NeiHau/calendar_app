// ignore_for_file: unused_import

import 'package:first_app/Day_detail/day_data.dart';
import 'package:riverpod/riverpod.dart';

class Day extends DayAbstract {
  @override
  late int date;

  @override
  late int weekday;

  late int month;
  late int year;

  Day(
      {required this.date,
      required this.weekday,
      required this.month,
      required this.year}) {
    if (weekday == 7) super.changeWeekday();
  }

  Day.
}
