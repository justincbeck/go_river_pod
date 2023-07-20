import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_provider.g.dart';

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
    state = null;
  }
}
