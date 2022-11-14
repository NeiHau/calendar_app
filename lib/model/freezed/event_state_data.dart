import 'package:first_app/model/db/todo_item_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_state_data.freezed.dart';

@freezed
abstract class TodoStateData with _$TodoStateData {
  //DBの状態を保持するクラス。
  factory TodoStateData({
    //@Default(false) bool isReadyData,
    @Default([]) List<TodoItemData> todoItems,
  }) = _TodoStateData;
}
