class ErrorResponse {
  final dynamic errors;
  final dynamic result;
  final dynamic datas;

  ErrorResponse({this.errors, this.result, this.datas});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      errors: json['errors'],
      result: json['result'],
      datas: json['datas'],
    );
  }

  String _unknownError() => "Unknown Error";

  String getAllErrorMessages() {
    if (errors == null) {
      return _unknownError();
    }

    // errors String bo‘lsa
    if (errors is String) {
      final value = errors.trim();
      return value.isNotEmpty ? value : _unknownError();
    }

    // errors Map<String, dynamic> bo‘lsa (field errors)
    if (errors is Map<String, dynamic>) {
      final List<String> allMessages = [];

      (errors as Map<String, dynamic>).forEach((_, value) {
        if (value is List) {
          allMessages.addAll(
            value.map((e) => e.toString()).where((e) => e.isNotEmpty),
          );
        } else if (value is String && value.isNotEmpty) {
          allMessages.add(value);
        }
      });

      return allMessages.isNotEmpty ? allMessages.join('\n') : _unknownError();
    }

    return _unknownError();
  }

  String getFirstErrorMessage() {
    if (errors == null) {
      return _unknownError();
    }

    if (errors is String) {
      final value = errors.trim();
      return value.isNotEmpty ? value : _unknownError();
    }

    if (errors is Map<String, dynamic>) {
      for (final value in (errors as Map<String, dynamic>).values) {
        if (value is List && value.isNotEmpty) {
          return value.first.toString();
        } else if (value is String && value.isNotEmpty) {
          return value;
        }
      }
    }

    return _unknownError();
  }

  Map<String, String> getFieldErrors() {
    if (errors is! Map<String, dynamic>) {
      return {};
    }

    final Map<String, String> fieldErrors = {};

    (errors as Map<String, dynamic>).forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        fieldErrors[key] = value.join('\n');
      } else if (value is String && value.isNotEmpty) {
        fieldErrors[key] = value;
      }
    });

    return fieldErrors;
  }

  @override
  String toString() => 'ErrorResponse(errors: $errors)';
}
