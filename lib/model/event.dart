import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
class Event with _$Event {
  //このクラスは、入力中のtodoを保持するクラスです。
  factory Event({
    @Default('') String title,
    @Default('') String description,
    @Default(null) DateTime? fromDay,
    @Default(null) DateTime? toDay,
    @Default(true) bool isAllDay,
  }) = _Event;
}
