import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/models/smarty_model.dart';
import 'package:go_riverpod_poc/providers/smarty_provider.dart';

class SmartySearch extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;
  const SmartySearch({super.key, required this.textEditingController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SmartySearchState();
}

class _SmartySearchState extends ConsumerState<SmartySearch> {
  final GlobalKey _formFieldKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<SmartyModel>(
      textEditingController: widget.textEditingController,
      focusNode: _focusNode,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          key: _formFieldKey,
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
                physics: const NeverScrollableScrollPhysics(),
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
        return ref
            .read(smartyProvider.notifier)
            .autoCompletePro(textEditingValue.text);
      },
      displayStringForOption: (option) {
        if (option.secondary.isNotEmpty && option.entries > 1) {
          return option.toSmartySearchString();
        }

        return option.toSmartySuggestionString();
      },
    );
  }
}
