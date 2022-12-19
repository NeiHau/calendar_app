import 'package:first_app/model/freezed/event.dart';
import 'package:first_app/view/calendarView/calendar_event_list.dart';
import 'package:first_app/view/calendarView/calendar_list.dart';
import 'package:first_app/view/calendarView/calendar_view.dart';
import 'package:first_app/view/eventAddingPage/event_adding_page.dart';
import 'package:first_app/view/eventEditingPage/event_editing_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String calendarPage = '/home';
  static const String calendarEventList = '/EventList';
  static const String eventAddingPage = '/AddingPage';
  static const String eventEditingPage = '/EditingPage';
  static const String calendarListDialog = '/EventListDialog';

  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case calendarPage:
        return MaterialPageRoute(
          builder: (context) => const CalendarPage(),
        );
      case calendarEventList:
        return MaterialPageRoute(
            builder: (context) =>
                CalendarEventList(currentDate: DateTime.now()));
      case eventAddingPage:
        final currentDate = settings.arguments as DateTime;
        return MaterialPageRoute(
            builder: (context) => EventAddingPage(currentDate: currentDate));
      case eventEditingPage:
        final arguments = settings.arguments as Event;
        return MaterialPageRoute(
            builder: (context) => EventEditingPage(arguments: arguments));
      case calendarListDialog:
        return MaterialPageRoute(
            builder: (context) =>
                CalendarListDialog(cacheDate: DateTime.now()));
      default:
        throw Exception('Route not found');
    }
  }
}
