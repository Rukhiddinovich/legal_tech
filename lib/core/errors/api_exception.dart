import 'package:dio/dio.dart';
import 'error_response.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final ErrorResponse? errorResponse;

  ApiException({required this.message, this.statusCode, this.errorResponse});

  factory ApiException.fromDioError(DioException error) {
    String message = "Server Error";
    int? statusCode = error.response?.statusCode;
    ErrorResponse? parsedError;

    try {
      final data = error.response?.data;

      if (data is Map<String, dynamic>) {
        parsedError = ErrorResponse.fromJson(data);

        if (parsedError.errors is Map<String, dynamic>) {
          message = parsedError.getAllErrorMessages();
        } else if (parsedError.errors is String &&
            (parsedError.errors as String).isNotEmpty) {
          message = parsedError.errors as String;
        } else if (data['message'] != null) {
          message = data['message'].toString();
        } else {
          message = "Server Error";
        }
      } else if (data is String) {
        message = data;
      } else {
        message = error.message ?? "Network Error";
      }
    } catch (e) {
      message = "Parsing Error";
    }

    if (statusCode == 401) {
      message = "Session Expired";
    }

    return ApiException(
      message: message,
      statusCode: statusCode,
      errorResponse: parsedError,
    );
  }

  Map<String, String> getFieldErrors() {
    return errorResponse?.getFieldErrors() ?? {};
  }

  @override
  String toString() => message;
}
