import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
abstract class Event with _$Event {
  //このクラスは、入力中のtodoを保持するクラスです。
  factory Event({
    String? id,
    //DateTime? selectedDate,
    @Default('') String title, // タイトル
    @Default('') String description, //コメント
    @Default(null) DateTime? startDate, // 開始日
    @Default(null) DateTime? endDate, // 終了日
    @Default(false) bool isAllDay, // 終日
  }) = _Event;
}
