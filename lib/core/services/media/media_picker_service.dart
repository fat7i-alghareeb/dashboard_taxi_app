import 'dart:io';

import 'package:image_picker/image_picker.dart';

enum MediaPickerFailure { unavailable, unsupportedType, tooLarge }

class MediaPickerResult {
  const MediaPickerResult.success(this.files) : failure = null;
  const MediaPickerResult.cancelled() : files = const <XFile>[], failure = null;
  const MediaPickerResult.failure(this.failure) : files = const <XFile>[];

  final List<XFile> files;
  final MediaPickerFailure? failure;

  bool get isSuccess => files.isNotEmpty && failure == null;
}

class MediaPickerService {
  MediaPickerService._();

  static const int maxFileSizeBytes = 10 * 1024 * 1024;
  static const Set<String> _supportedExtensions = <String>{
    'jpg',
    'jpeg',
    'png',
    'webp',
  };

  final ImagePicker _picker = ImagePicker();
  List<XFile> _recoveredFiles = const <XFile>[];
  MediaPickerFailure? _recoveryFailure;

  Future<void> initialize() async {
    if (!Platform.isAndroid) return;
    try {
      final response = await _picker.retrieveLostData();
      if (response.isEmpty) return;
      if (response.exception != null) {
        _recoveryFailure = MediaPickerFailure.unavailable;
        return;
      }
      _recoveredFiles = await _validated(response.files ?? const <XFile>[]);
    } catch (_) {
      _recoveryFailure = MediaPickerFailure.unavailable;
    }
  }

  Future<MediaPickerResult> pickSingle(ImageSource source) async {
    final recovered = await _consumeRecovered(single: true);
    if (recovered != null) return recovered;
    try {
      final file = await _picker.pickImage(
        source: source,
        imageQuality: 75,
        maxWidth: 2048,
        maxHeight: 2048,
      );
      if (file == null) return const MediaPickerResult.cancelled();
      return _validateResult(<XFile>[file]);
    } catch (_) {
      return const MediaPickerResult.failure(MediaPickerFailure.unavailable);
    }
  }

  Future<MediaPickerResult> pickMultiple() async {
    final recovered = await _consumeRecovered(single: false);
    if (recovered != null) return recovered;
    try {
      final files = await _picker.pickMultiImage(
        imageQuality: 75,
        maxWidth: 2048,
        maxHeight: 2048,
      );
      if (files.isEmpty) return const MediaPickerResult.cancelled();
      return _validateResult(files);
    } catch (_) {
      return const MediaPickerResult.failure(MediaPickerFailure.unavailable);
    }
  }

  Future<MediaPickerResult?> _consumeRecovered({required bool single}) async {
    final failure = _recoveryFailure;
    _recoveryFailure = null;
    if (failure != null) return MediaPickerResult.failure(failure);
    if (_recoveredFiles.isEmpty) return null;

    final files = single
        ? <XFile>[_recoveredFiles.first]
        : List<XFile>.of(_recoveredFiles);
    _recoveredFiles = const <XFile>[];
    return _validateResult(files);
  }

  Future<MediaPickerResult> _validateResult(List<XFile> files) async {
    for (final file in files) {
      final extension = file.path.split('.').last.toLowerCase();
      if (!_supportedExtensions.contains(extension)) {
        return const MediaPickerResult.failure(
          MediaPickerFailure.unsupportedType,
        );
      }
      if (await file.length() > maxFileSizeBytes) {
        return const MediaPickerResult.failure(MediaPickerFailure.tooLarge);
      }
    }
    return MediaPickerResult.success(files);
  }

  Future<List<XFile>> _validated(List<XFile> files) async {
    final result = await _validateResult(files);
    if (result.failure != null) {
      _recoveryFailure = result.failure;
      return const <XFile>[];
    }
    return result.files;
  }
}

final MediaPickerService appMediaPickerService = MediaPickerService._();
