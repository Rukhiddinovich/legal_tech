import 'package:flutter/services.dart';

class PassportInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String text = newValue.text.toUpperCase();

    // Limit length to 9
    if (text.length > 9) {
      text = text.substring(0, 9);
    }

    // Validate characters
    for (int i = 0; i < text.length; i++) {
      if (i < 2) {
        // Must be a letter
        if (!RegExp(r'[A-Z]').hasMatch(text[i])) {
          return oldValue;
        }
      } else {
        // Must be a digit
        if (!RegExp(r'[0-9]').hasMatch(text[i])) {
          return oldValue;
        }
      }
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: newValue.selection.end.clamp(0, text.length),
      ),
    );
  }
}
