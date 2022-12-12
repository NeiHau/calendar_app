import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
abstract class Event with _$Event {
  // 入力中のデータを保持するクラス。
  factory Event({
    required String id,
    required String title, // タイトル
    required String description, //コメント
    required DateTime startDate, // 開始日
    required DateTime endDate, // 終了日
    required bool isAllDay, // 終日
    // required bool isUpdated, // タイトルとコメントが更新をされたかどうかを判定する。
  }) = _Event;
}
