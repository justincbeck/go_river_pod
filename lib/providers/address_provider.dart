import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_provider.g.dart';

/// placeholder provider for address info since we don't submit
/// until after we've successfully submitted sign up credentials
@Riverpod(keepAlive: true)
class Address extends _$Address {
  @override
  String? build() {
    return null;
  }

  void setAddress(String address) {
    state = address;
  }

  void reset() {
    return ref.invalidateSelf();
  }
}
