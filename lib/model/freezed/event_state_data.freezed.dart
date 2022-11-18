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
  Map<DateTime, List<Event>> get todoItemsMap =>
      throw _privateConstructorUsedError;

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
  $Res call({Map<DateTime, List<Event>> todoItemsMap});
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
    Object? todoItemsMap = null,
  }) {
    return _then(_value.copyWith(
      todoItemsMap: null == todoItemsMap
          ? _value.todoItemsMap
          : todoItemsMap // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<Event>>,
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
  $Res call({Map<DateTime, List<Event>> todoItemsMap});
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
    Object? todoItemsMap = null,
  }) {
    return _then(_$_TodoStateData(
      todoItemsMap: null == todoItemsMap
          ? _value._todoItemsMap
          : todoItemsMap // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List<Event>>,
    ));
  }
}

/// @nodoc

class _$_TodoStateData implements _TodoStateData {
  _$_TodoStateData({final Map<DateTime, List<Event>> todoItemsMap = const {}})
      : _todoItemsMap = todoItemsMap;

  final Map<DateTime, List<Event>> _todoItemsMap;
  @override
  @JsonKey()
  Map<DateTime, List<Event>> get todoItemsMap {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_todoItemsMap);
  }

  @override
  String toString() {
    return 'TodoStateData(todoItemsMap: $todoItemsMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoStateData &&
            const DeepCollectionEquality()
                .equals(other._todoItemsMap, _todoItemsMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_todoItemsMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoStateDataCopyWith<_$_TodoStateData> get copyWith =>
      __$$_TodoStateDataCopyWithImpl<_$_TodoStateData>(this, _$identity);
}

abstract class _TodoStateData implements TodoStateData {
  factory _TodoStateData({final Map<DateTime, List<Event>> todoItemsMap}) =
      _$_TodoStateData;

  @override
  Map<DateTime, List<Event>> get todoItemsMap;
  @override
  @JsonKey(ignore: true)
  _$$_TodoStateDataCopyWith<_$_TodoStateData> get copyWith =>
      throw _privateConstructorUsedError;
}
