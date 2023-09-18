import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/models/smarty_model.dart';
import 'package:go_riverpod_poc/providers/home_provider.dart';
import 'package:go_riverpod_poc/providers/smarty_provider.dart';
import 'package:go_riverpod_poc/widgets/smarty_search/debounceable.dart';

class SmartySearch extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;
  const SmartySearch({
    super.key,
    required this.textEditingController,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SmartySearchState();
}

class _SmartySearchState extends ConsumerState<SmartySearch> {
  final GlobalKey _formFieldKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  late final Debounceable<Iterable<SmartyModel>?, String> _debouncedSearch;

  String currentPattern = '';
  String? _currentQuery;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _debouncedSearch = debounce<Iterable<SmartyModel>?, String>(_search);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isCreatingHome = ref.watch(homeProvider).isLoading;

    return RawAutocomplete<SmartyModel>(
      textEditingController: widget.textEditingController,
      focusNode: _focusNode,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          key: _formFieldKey,
          readOnly: isCreatingHome,
          controller: textEditingController,
          style: Theme.of(context).textTheme.bodyMedium,
          focusNode: focusNode,
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: (_formFieldKey.currentContext?.findRenderObject()
                        as RenderBox)
                    .size
                    .width,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: options.length,
                separatorBuilder: (context, i) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  SmartyModel address = options.elementAt(index);

                  return GestureDetector(
                    onTap: () async {
                      await ref
                          .read(smartyProvider.notifier)
                          .selectSmartyModel(address);

                      if (address.entries > 1) {
                        widget.textEditingController.text =
                            address.toSmartySearchString();
                        _focusNode.requestFocus();
                      } else {
                        widget.textEditingController.text = address.toString();
                        _focusNode.unfocus();
                      }

                      widget.textEditingController.selection =
                          TextSelection.collapsed(
                        offset: widget.textEditingController.text.length,
                      );
                    },
                    child: Builder(
                      builder: (context) {
                        if (address.entries > 1) {
                          return ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(address.toSmartySuggestionString()),
                          );
                        }

                        return ListTile(
                          visualDensity: VisualDensity.compact,
                          title: Text(address.toString()),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        var pattern = textEditingValue.text;

        if (pattern != currentPattern) {
          if (pattern.isEmpty) {
            ref.read(smartyProvider.notifier).reset();
          }
          if (!pattern.contains(currentPattern)) {
            ref.read(smartyProvider.notifier).reset();
          }
        }
        currentPattern = pattern;

        final value = await _debouncedSearch(pattern);

        return value ?? [];
      },
      displayStringForOption: (option) {
        if (option.secondary.isNotEmpty && option.entries > 1) {
          return option.toSmartySearchString();
        }

        return option.toSmartySuggestionString();
      },
    );
  }

  Future<Iterable<SmartyModel>> _search(String query) async {
    _currentQuery = query;

    late final Iterable<SmartyModel>? options;
    try {
      options = await ref.read(smartyProvider.notifier).autoCompletePro(query);
    } catch (e) {
      rethrow;
    }

    if (_currentQuery != query) {
      return Future.value([]);
    }
    _currentQuery = null;

    return options;
  }
}
