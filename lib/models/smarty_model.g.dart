// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smarty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SmartyModel _$$_SmartyModelFromJson(Map<String, dynamic> json) =>
    _$_SmartyModel(
      streetLine: json['street_line'] as String,
      secondary: json['secondary'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipcode'] as String,
      entries: json['entries'] as int,
    );

Map<String, dynamic> _$$_SmartyModelToJson(_$_SmartyModel instance) =>
    <String, dynamic>{
      'street_line': instance.streetLine,
      'secondary': instance.secondary,
      'city': instance.city,
      'state': instance.state,
      'zipcode': instance.zipCode,
      'entries': instance.entries,
    };
