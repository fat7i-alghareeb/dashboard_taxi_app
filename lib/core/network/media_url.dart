import 'api_config.dart';

/// Resolves a possibly-relative media URL (e.g. "/recordings/x.m4a") returned by
/// the API into an absolute URL against the API host. Absolute URLs (http/https)
/// are returned unchanged. Mirrors the rule used by `AppImageViewer.network`.
String resolveMediaUrl(String url) =>
    url.startsWith('/') ? '${ApiConfig.baseUrl}$url' : url;
