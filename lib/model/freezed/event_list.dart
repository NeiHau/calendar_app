import 'package:first_app/model/database/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_list.freezed.dart';

@freezed
class TodoEventList with _$TodoEventList {
  // データベースの状態を管理するクラス。
  factory TodoEventList({
    @Default([]) List<Event> todoItems,
    @Default(false) bool isUpdated,
  }) = _TodoEventList;
}
