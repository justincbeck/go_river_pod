// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addressHash() => r'a77499a443f0c33707b2286dbdeb34c2741889a3';

/// placeholder provider for address info since we don't submit
/// until after we've successfully submitted sign up credentials
///
/// Copied from [Address].
@ProviderFor(Address)
final addressProvider = NotifierProvider<Address, String?>.internal(
  Address.new,
  name: r'addressProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$addressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Address = Notifier<String?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
