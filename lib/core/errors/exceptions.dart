class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);

  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(this.message);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);

  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => message;
}

class ErrorResponse {
  final dynamic result;
  final Map<String, List<String>>? errors;
  final dynamic datas;

  ErrorResponse({this.result, this.errors, this.datas});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>>? errors;

    if (json['errors'] != null && json['errors'] is Map) {
      errors = {};
      (json['errors'] as Map).forEach((key, value) {
        if (value is List) {
          errors![key] = List<String>.from(value.map((e) => e.toString()));
        }
      });
    }

    return ErrorResponse(
      result: json['result'],
      errors: errors,
      datas: json['datas'],
    );
  }

  /// Barcha xatolik xabarlarini bitta string ko'rinishida qaytaradi
  String getAllErrorMessages() {
    if (errors == null || errors!.isEmpty) {
      return "Errors Occurred";
    }

    final List<String> allMessages = [];
    errors!.forEach((key, messages) {
      allMessages.addAll(messages);
    });

    return allMessages.join('\n');
  }

  /// Birinchi xatolik xabarini qaytaradi
  String getFirstErrorMessage() {
    if (errors == null || errors!.isEmpty) {
      return "Errors Occurred";
    }

    final firstKey = errors!.keys.first;
    final messages = errors![firstKey];

    if (messages != null && messages.isNotEmpty) {
      return messages.first;
    }

    return "Errors Occurred";
  }

  /// Ma'lum bir field uchun xatolik xabarlarini qaytaradi
  List<String>? getErrorsForField(String fieldName) {
    return errors?[fieldName];
  }

  /// Xatolik borligini tekshiradi
  bool hasErrors() {
    return errors != null && errors!.isNotEmpty;
  }

  /// Ma'lum bir field uchun xatolik borligini tekshiradi
  bool hasErrorForField(String fieldName) {
    return errors?.containsKey(fieldName) ?? false;
  }
}
