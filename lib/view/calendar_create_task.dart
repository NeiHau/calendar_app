import 'package:first_app/page/event_adding_page.dart';
import 'package:first_app/view/calendar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({super.key});

  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  Widget build(BuildContext context) {
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
                      ref.read(nowProvider).day,
                    ),
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
  }
}
