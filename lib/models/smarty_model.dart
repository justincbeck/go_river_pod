import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';

part 'smarty_model.freezed.dart';
part 'smarty_model.g.dart';

@freezed
class SmartyModel with _$SmartyModel {
  const SmartyModel._();

  factory SmartyModel({
    @JsonKey(name: 'street_line') required String streetLine,
    required String secondary,
    required String city,
    required String state,
    @JsonKey(name: 'zipcode') required String zipCode,
    required int entries,
  }) = _SmartyModel;

  factory SmartyModel.fromJson(Map<String, Object?> json) =>
      _$SmartyModelFromJson(json);

  factory SmartyModel.fromPlacemark(Placemark placemark) {
    return SmartyModel(
      streetLine: placemark.street ?? '',
      secondary: '',
      city: placemark.locality ?? '',
      state: placemark.isoCountryCode ?? 'US',
      zipCode: placemark.postalCode ?? '',
      entries: 1,
    );
  }

  String toSmartySearchString() {
    return '$streetLine $secondary';
  }

  String toSmartySelectedString() {
    if (secondary.isNotEmpty) {
      return '$streetLine $secondary ($entries) $city $state $zipCode';
    }

    return '$streetLine ($entries) $city $state $zipCode';
  }

  String toSmartySuggestionString() {
    String streetAddress = streetLine;
    if (secondary.isNotEmpty) {
      streetAddress = '$streetAddress $secondary';
    }
    if (entries > 1) {
      streetAddress = '$streetAddress ($entries more entries)';
    }
    String address = '$streetAddress $city, $state';

    return address;
  }

  @override
  String toString() {
    if (secondary.isNotEmpty) {
      return '$streetLine $secondary $city, $state $zipCode';
    }

    return '$streetLine $city, $state $zipCode';
  }
}
