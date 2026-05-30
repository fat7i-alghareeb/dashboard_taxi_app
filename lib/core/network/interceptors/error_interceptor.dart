import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/helpers/app_strings.dart';
import '../../error/app_exception.dart';

/// Interceptor that converts all [DioException]s into [AppException]
/// with localized, user-friendly messages.
///
/// The mapping is intentionally opinionated but small:
/// //! 1) Transport issues (no internet, timeouts, TLS)
/// //! 2) Cancellations
/// //! 3) HTTP status codes (auth, client, server)
/// //! 4) Other DioException types (badCertificate / unknown)
/// //! 5) Fallback + safety net
@lazySingleton
class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final mapped = _mapDioError(err);
    handler.reject(err.copyWith(error: mapped));
  }

  /// Core mapping pipeline from [DioException] to [AppException].
  ///
  /// The order is important because we want to:
  /// - Detect offline/timeouts early.
  /// - Map well-known HTTP statuses to specific messages.
  /// - Always return *something* even if parsing fails.
  AppException _mapDioError(DioException error) {
    try {
      //! 1) Transport-level issues (no internet, timeouts, TLS)
      if (_isNoInternet(error)) {
        return AppException.known(AppStrings.networkNoInternet);
      }
      if (_isTimeout(error)) {
        return AppException.known(AppStrings.networkTimeout);
      }
      if (error.type == DioExceptionType.connectionError) {
        return AppException.known(AppStrings.networkConnectionError);
      }

      //! 2) Cancellation
      if (error.type == DioExceptionType.cancel) {
        return AppException.known(AppStrings.requestCancelled);
      }

      //! 3) HTTP error responses
      if (error.type == DioExceptionType.badResponse) {
        final int? status = error.response?.statusCode;
        final String? apiMsg = _extractApiMessage(error.response);

        //? 3.1) Auth-related statuses
        if (status == 401) {
          return AppException.known(apiMsg ?? AppStrings.authUnauthorized);
        }
        if (status == 403) {
          return AppException.known(apiMsg ?? AppStrings.authForbidden);
        }

        //? 3.2) Client errors
        if (status == 400) {
          return AppException.known(apiMsg ?? AppStrings.clientBadRequest);
        }
        if (status == 404) {
          return AppException.known(apiMsg ?? AppStrings.clientNotFound);
        }
        if (status == 409) {
          return AppException.known(apiMsg ?? AppStrings.clientConflict);
        }
        if (status == 422) {
          return AppException.known(
            apiMsg ?? AppStrings.clientUnprocessableEntity,
          );
        }

        //? 3.3) Server errors
        if (status == 500) {
          return AppException.known(apiMsg ?? AppStrings.serverError);
        }
        if (status == 503) {
          return AppException.known(apiMsg ?? AppStrings.serverServiceUnavailable);
        }

        //? 3.4) Unknown HTTP status
        return AppException.known(apiMsg ?? AppStrings.unknownError);
      }

      //! 4) Other DioException types
      if (error.type == DioExceptionType.badCertificate) {
        return AppException.known(AppStrings.networkCertificateError);
      }
      if (error.type == DioExceptionType.unknown) {
        final underlying = error.error;
        if (underlying is FormatException) {
          return AppException.known(AppStrings.decodeError);
        }
        if (underlying is IOException) {
          return AppException.known(AppStrings.networkConnectionError);
        }
        return AppException.known(AppStrings.unknownError);
      }

      //! 5) Fallback
      return AppException.known(AppStrings.unknownError);
    } catch (_) {
      //? Safety net: never crash the app from mapping logic
      return AppException.unknown();
    }
  }

  /// Tries to extract a human-friendly message from a typical API error
  /// payload. Common backend shapes are supported:
  /// - `{ "errors": { "field": ["msg"] } }` (ValidationProblemDetails)
  /// - `{ "message": "..." }`
  /// - `{ "error": "..." }`
  /// - `{ "title": "..." }` (ProblemDetails)
  /// - `{ "detail": "..." }`
  String? _extractApiMessage(Response<dynamic>? response) {
    if (response == null) return null;
    final data = response.data;
    if (data == null) return null;
    if (data is String && data.trim().isNotEmpty) return data;
    if (data is Map) {
      final String? validationMessage = _extractValidationMessage(data);
      if (validationMessage != null) return validationMessage;

      final String? message = _readString(data['message']) ??
          _readString(data['error']);
      final String? title = _readString(data['title']);
      final String? detail = _readString(data['detail']);

      if (message != null) return message;

      final String? combined = _combineTitleDetail(title, detail);
      if (combined != null) return combined;
    }
    return null;
  }

  String? _extractValidationMessage(Map data) {
    final Object? errors = data['errors'];
    if (errors is! Map) return null;

    final List<String> messages = <String>[];
    for (final Object? value in errors.values) {
      _collectMessages(value, messages);
    }

    if (messages.isEmpty) return null;
    return messages.join('\n');
  }

  void _collectMessages(Object? value, List<String> messages) {
    if (value is String) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) messages.add(trimmed);
      return;
    }
    if (value is Iterable) {
      for (final Object? item in value) {
        _collectMessages(item, messages);
      }
      return;
    }
    if (value is Map) {
      for (final Object? item in value.values) {
        _collectMessages(item, messages);
      }
    }
  }

  String? _readString(Object? value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String? _combineTitleDetail(String? title, String? detail) {
    if (title == null && detail == null) return null;
    if (title != null && detail != null && title != detail) {
      return '$title\n$detail';
    }
    return title ?? detail;
  }

  bool _isTimeout(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout;
  }

  /// Rough check for offline / DNS issues using the underlying error type.
  bool _isNoInternet(DioException e) {
    return e.error is SocketException;
  }
}
