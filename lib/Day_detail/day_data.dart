import 'dart:html';

abstract class DayAbstract extends Calender {
  int date = 1;
  int weekday = 1;

  int changeWeekday() => weekday = 0;

  String convertWeekday({required int weekday}) {
    switch (weekday) {
      case 0:
        return '日';
      case 1:
        return '月';
      case 2:
        return '火';
      case 3:
        return '水';
      case 4:
        return '木';
      case 5:
        return '金';
      case 6:
        return '土';
    }
    return 'day';
  }
}
