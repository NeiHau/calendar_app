// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'event_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TodoEventList {
  List<Event> get todoItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoEventListCopyWith<TodoEventList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoEventListCopyWith<$Res> {
  factory $TodoEventListCopyWith(
          TodoEventList value, $Res Function(TodoEventList) then) =
      _$TodoEventListCopyWithImpl<$Res, TodoEventList>;
  @useResult
  $Res call({List<Event> todoItems});
}

/// @nodoc
class _$TodoEventListCopyWithImpl<$Res, $Val extends TodoEventList>
    implements $TodoEventListCopyWith<$Res> {
  _$TodoEventListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoItems = null,
  }) {
    return _then(_value.copyWith(
      todoItems: null == todoItems
          ? _value.todoItems
          : todoItems // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TodoEventListCopyWith<$Res>
    implements $TodoEventListCopyWith<$Res> {
  factory _$$_TodoEventListCopyWith(
          _$_TodoEventList value, $Res Function(_$_TodoEventList) then) =
      __$$_TodoEventListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Event> todoItems});
}

/// @nodoc
class __$$_TodoEventListCopyWithImpl<$Res>
    extends _$TodoEventListCopyWithImpl<$Res, _$_TodoEventList>
    implements _$$_TodoEventListCopyWith<$Res> {
  __$$_TodoEventListCopyWithImpl(
      _$_TodoEventList _value, $Res Function(_$_TodoEventList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoItems = null,
  }) {
    return _then(_$_TodoEventList(
      todoItems: null == todoItems
          ? _value._todoItems
          : todoItems // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ));
  }
}

/// @nodoc

class _$_TodoEventList implements _TodoEventList {
  _$_TodoEventList({final List<Event> todoItems = const []})
      : _todoItems = todoItems;

  final List<Event> _todoItems;
  @override
  @JsonKey()
  List<Event> get todoItems {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todoItems);
  }

  @override
  String toString() {
    return 'TodoEventList(todoItems: $todoItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoEventList &&
            const DeepCollectionEquality()
                .equals(other._todoItems, _todoItems));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_todoItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoEventListCopyWith<_$_TodoEventList> get copyWith =>
      __$$_TodoEventListCopyWithImpl<_$_TodoEventList>(this, _$identity);
}

abstract class _TodoEventList implements TodoEventList {
  factory _TodoEventList({final List<Event> todoItems}) = _$_TodoEventList;

  @override
  List<Event> get todoItems;
  @override
  @JsonKey(ignore: true)
  _$$_TodoEventListCopyWith<_$_TodoEventList> get copyWith =>
      throw _privateConstructorUsedError;
}
