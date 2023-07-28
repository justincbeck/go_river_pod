import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/models/smarty_model.dart';
import 'package:logging/logging.dart';

class SmartyApi {
  final Logger logger = Logger('SmartyApi');

  final Ref ref;
  late final Dio _dio;

  static String autocompleteSubDomain = 'us-autocomplete-pro';
  static String streetAddressSubDomain = 'us-street';
  static String domain = 'api.smartystreets.com';

  static String autoCompleteBase = 'https://$autocompleteSubDomain.$domain';
  String searchPath = '$autoCompleteBase/lookup';

  Map<String, String> headers = {
    Headers.contentTypeHeader: 'application/json; charset=UTF-8',
    Headers.acceptHeader: 'application/json',
  };

  SmartyApi({required this.ref}) {
    _dio = Dio();
    _dio.options.baseUrl = autoCompleteBase;
  }

  FutureOr<List<SmartyModel>> autoCompletePro(
    String searchTerm,
    String? selected,
  ) async {
    var encodedSearch = Uri.encodeComponent(searchTerm);

    if (selected != null) {
      String encodedSelected = Uri.encodeComponent(selected);
      encodedSearch = '$encodedSearch&selected=$encodedSelected';
    }

    var uri = Uri.parse(
      '$searchPath?key=${dotenv.env['SMARTY_KEY']}&search=$encodedSearch',
    );
    var h = {
      ...headers,
      'referer': dotenv.env['SMARTY_REFERER'],
    };

    Response<dynamic> response;

    try {
      response = await _dio.getUri(
        uri,
        options: Options(headers: h),
      );

      var json = response.data;
      List<dynamic> mappable = json['suggestions'];
      List<SmartyModel> mapped = mappable.map((result) {
        var model = SmartyModel.fromJson(result);

        return model;
      }).toList();

      return mapped;
    } on DioException {
      return List<SmartyModel>.empty();
    }
  }
}

final smartyApiProvider = Provider<SmartyApi>((ref) {
  return SmartyApi(ref: ref);
});
