import 'package:first_app/view/calendar_event_list.dart';
import 'package:first_app/view/calendar_list.dart';
import 'package:first_app/view/eventAdding/EditingPage/event_adding_page.dart';
import 'package:first_app/view/eventAdding/EditingPage/event_editing_page.dart';
import 'package:first_app/view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
      ],
      debugShowCheckedModeBanner: false,
      title: '自作カレンダー',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "/home": (context) => const CalendarPage(),
        "/EventList": (context) =>
            CalendarEventList(currentDate: DateTime.now()),
        "/EditingPage": (context) => const EventEditingPage(),
        "/AddingPage": (context) => const EventAddingPage(),
        "/ListEvent": (context) => const CalendarListDialog(),
      },
      home: const CalendarPage(),
    );
  }
}
