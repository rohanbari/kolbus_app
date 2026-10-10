import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kolbus_app/providers/backend_service_provider.dart';

class AutoFieldWidget extends ConsumerWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final Widget? suffix;

  const AutoFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.enabled,
    this.suffix,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Autocomplete<String>(
      focusNode: focusNode,
      textEditingController: controller,
      optionsBuilder: (textEditingValue) async {
        return await ref.refresh(
          suggestionsProvider(textEditingValue.text).future,
        );
      },
      onSelected: (selection) {
        controller.text = selection;
      },
      fieldViewBuilder: (context, fieldController, focusNode, _) {
        controller.value = fieldController.value;

        return TextField(
          enabled: enabled,
          controller: fieldController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            suffixIcon: suffix,
          ),
        );
      },
    );
  }
}
