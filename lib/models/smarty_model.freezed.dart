// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smarty_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SmartyModel _$SmartyModelFromJson(Map<String, dynamic> json) {
  return _SmartyModel.fromJson(json);
}

/// @nodoc
mixin _$SmartyModel {
  @JsonKey(name: 'street_line')
  String get streetLine => throw _privateConstructorUsedError;
  String get secondary => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'zipcode')
  String get zipCode => throw _privateConstructorUsedError;
  int get entries => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmartyModelCopyWith<SmartyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartyModelCopyWith<$Res> {
  factory $SmartyModelCopyWith(
          SmartyModel value, $Res Function(SmartyModel) then) =
      _$SmartyModelCopyWithImpl<$Res, SmartyModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'street_line') String streetLine,
      String secondary,
      String city,
      String state,
      @JsonKey(name: 'zipcode') String zipCode,
      int entries});
}

/// @nodoc
class _$SmartyModelCopyWithImpl<$Res, $Val extends SmartyModel>
    implements $SmartyModelCopyWith<$Res> {
  _$SmartyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streetLine = null,
    Object? secondary = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? entries = null,
  }) {
    return _then(_value.copyWith(
      streetLine: null == streetLine
          ? _value.streetLine
          : streetLine // ignore: cast_nullable_to_non_nullable
              as String,
      secondary: null == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SmartyModelCopyWith<$Res>
    implements $SmartyModelCopyWith<$Res> {
  factory _$$_SmartyModelCopyWith(
          _$_SmartyModel value, $Res Function(_$_SmartyModel) then) =
      __$$_SmartyModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'street_line') String streetLine,
      String secondary,
      String city,
      String state,
      @JsonKey(name: 'zipcode') String zipCode,
      int entries});
}

/// @nodoc
class __$$_SmartyModelCopyWithImpl<$Res>
    extends _$SmartyModelCopyWithImpl<$Res, _$_SmartyModel>
    implements _$$_SmartyModelCopyWith<$Res> {
  __$$_SmartyModelCopyWithImpl(
      _$_SmartyModel _value, $Res Function(_$_SmartyModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streetLine = null,
    Object? secondary = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? entries = null,
  }) {
    return _then(_$_SmartyModel(
      streetLine: null == streetLine
          ? _value.streetLine
          : streetLine // ignore: cast_nullable_to_non_nullable
              as String,
      secondary: null == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SmartyModel extends _SmartyModel {
  _$_SmartyModel(
      {@JsonKey(name: 'street_line') required this.streetLine,
      required this.secondary,
      required this.city,
      required this.state,
      @JsonKey(name: 'zipcode') required this.zipCode,
      required this.entries})
      : super._();

  factory _$_SmartyModel.fromJson(Map<String, dynamic> json) =>
      _$$_SmartyModelFromJson(json);

  @override
  @JsonKey(name: 'street_line')
  final String streetLine;
  @override
  final String secondary;
  @override
  final String city;
  @override
  final String state;
  @override
  @JsonKey(name: 'zipcode')
  final String zipCode;
  @override
  final int entries;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SmartyModel &&
            (identical(other.streetLine, streetLine) ||
                other.streetLine == streetLine) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.entries, entries) || other.entries == entries));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, streetLine, secondary, city, state, zipCode, entries);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SmartyModelCopyWith<_$_SmartyModel> get copyWith =>
      __$$_SmartyModelCopyWithImpl<_$_SmartyModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SmartyModelToJson(
      this,
    );
  }
}

abstract class _SmartyModel extends SmartyModel {
  factory _SmartyModel(
      {@JsonKey(name: 'street_line') required final String streetLine,
      required final String secondary,
      required final String city,
      required final String state,
      @JsonKey(name: 'zipcode') required final String zipCode,
      required final int entries}) = _$_SmartyModel;
  _SmartyModel._() : super._();

  factory _SmartyModel.fromJson(Map<String, dynamic> json) =
      _$_SmartyModel.fromJson;

  @override
  @JsonKey(name: 'street_line')
  String get streetLine;
  @override
  String get secondary;
  @override
  String get city;
  @override
  String get state;
  @override
  @JsonKey(name: 'zipcode')
  String get zipCode;
  @override
  int get entries;
  @override
  @JsonKey(ignore: true)
  _$$_SmartyModelCopyWith<_$_SmartyModel> get copyWith =>
      throw _privateConstructorUsedError;
}
