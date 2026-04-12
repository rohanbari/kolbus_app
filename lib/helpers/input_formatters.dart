import 'package:flutter/services.dart';

class SpaceTrimmedInputFormmater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(text: 'Test');
  }
}
