import 'package:first_app/model/database/todo_item_data.dart';
import 'package:first_app/model/freezed/event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_state_data.freezed.dart';

@freezed
class TodoStateData with _$TodoStateData {
  // データベースの状態を管理するクラス。
  factory TodoStateData({
    @Default({}) Map<DateTime, List<Event>> todoItemsMap,
    //const factory @Default(true) Assert
  }) = _TodoStateData;
}
