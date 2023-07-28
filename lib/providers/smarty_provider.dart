import 'package:go_riverpod_poc/api/smarty_api.dart';
import 'package:go_riverpod_poc/models/smarty_model.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'smarty_provider.g.dart';

@Riverpod(keepAlive: true)
class Smarty extends _$Smarty {
  final Logger logger = Logger('SmartyProvider');

  @override
  FutureOr<SmartyModel?> build() async {
    return null;
  }

  Future<void> selectSmartyModel(SmartyModel smartyModel) async {
    logger.info('selectSmartyModel()');
    state = AsyncValue.data(smartyModel);
  }

  Future<void> reset() async {
    return ref.invalidateSelf();
  }

  FutureOr<List<SmartyModel>> autoCompletePro(String searchTerm) async {
    logger.info('autoCompletePro()');
    final results =
        ref.read(smartyApiProvider).autoCompletePro(searchTerm, null);
    return results;
  }
}
