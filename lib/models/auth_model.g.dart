// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthModel _$$_AuthModelFromJson(Map<String, dynamic> json) => _$_AuthModel(
      username: json['username'] as String?,
      authState: $enumDecode(_$AuthStateEnumMap, json['authState']),
    );

Map<String, dynamic> _$$_AuthModelToJson(_$_AuthModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'authState': _$AuthStateEnumMap[instance.authState]!,
    };

const _$AuthStateEnumMap = {
  AuthState.signingUp: 'signingUp',
  AuthState.loggingIn: 'loggingIn',
  AuthState.loggedIn: 'loggedIn',
  AuthState.loggingOut: 'loggingOut',
  AuthState.loggedOut: 'loggedOut',
};
