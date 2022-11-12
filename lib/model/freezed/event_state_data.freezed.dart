// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'event_state_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TodoStateData {
//@Default(false) bool isLoading,
  bool get isReadyData => throw _privateConstructorUsedError;
  List<TodoItemData> get todoItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoStateDataCopyWith<TodoStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoStateDataCopyWith<$Res> {
  factory $TodoStateDataCopyWith(
          TodoStateData value, $Res Function(TodoStateData) then) =
      _$TodoStateDataCopyWithImpl<$Res, TodoStateData>;
  @useResult
  $Res call({bool isReadyData, List<TodoItemData> todoItems});
}

/// @nodoc
class _$TodoStateDataCopyWithImpl<$Res, $Val extends TodoStateData>
    implements $TodoStateDataCopyWith<$Res> {
  _$TodoStateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isReadyData = null,
    Object? todoItems = null,
  }) {
    return _then(_value.copyWith(
      isReadyData: null == isReadyData
          ? _value.isReadyData
          : isReadyData // ignore: cast_nullable_to_non_nullable
              as bool,
      todoItems: null == todoItems
          ? _value.todoItems
          : todoItems // ignore: cast_nullable_to_non_nullable
              as List<TodoItemData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TodoStateDataCopyWith<$Res>
    implements $TodoStateDataCopyWith<$Res> {
  factory _$$_TodoStateDataCopyWith(
          _$_TodoStateData value, $Res Function(_$_TodoStateData) then) =
      __$$_TodoStateDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isReadyData, List<TodoItemData> todoItems});
}

/// @nodoc
class __$$_TodoStateDataCopyWithImpl<$Res>
    extends _$TodoStateDataCopyWithImpl<$Res, _$_TodoStateData>
    implements _$$_TodoStateDataCopyWith<$Res> {
  __$$_TodoStateDataCopyWithImpl(
      _$_TodoStateData _value, $Res Function(_$_TodoStateData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isReadyData = null,
    Object? todoItems = null,
  }) {
    return _then(_$_TodoStateData(
      isReadyData: null == isReadyData
          ? _value.isReadyData
          : isReadyData // ignore: cast_nullable_to_non_nullable
              as bool,
      todoItems: null == todoItems
          ? _value._todoItems
          : todoItems // ignore: cast_nullable_to_non_nullable
              as List<TodoItemData>,
    ));
  }
}

/// @nodoc

class _$_TodoStateData implements _TodoStateData {
  _$_TodoStateData(
      {this.isReadyData = false, final List<TodoItemData> todoItems = const []})
      : _todoItems = todoItems;

//@Default(false) bool isLoading,
  @override
  @JsonKey()
  final bool isReadyData;
  final List<TodoItemData> _todoItems;
  @override
  @JsonKey()
  List<TodoItemData> get todoItems {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todoItems);
  }

  @override
  String toString() {
    return 'TodoStateData(isReadyData: $isReadyData, todoItems: $todoItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoStateData &&
            (identical(other.isReadyData, isReadyData) ||
                other.isReadyData == isReadyData) &&
            const DeepCollectionEquality()
                .equals(other._todoItems, _todoItems));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isReadyData,
      const DeepCollectionEquality().hash(_todoItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoStateDataCopyWith<_$_TodoStateData> get copyWith =>
      __$$_TodoStateDataCopyWithImpl<_$_TodoStateData>(this, _$identity);
}

abstract class _TodoStateData implements TodoStateData {
  factory _TodoStateData(
      {final bool isReadyData,
      final List<TodoItemData> todoItems}) = _$_TodoStateData;

  @override //@Default(false) bool isLoading,
  bool get isReadyData;
  @override
  List<TodoItemData> get todoItems;
  @override
  @JsonKey(ignore: true)
  _$$_TodoStateDataCopyWith<_$_TodoStateData> get copyWith =>
      throw _privateConstructorUsedError;
}
