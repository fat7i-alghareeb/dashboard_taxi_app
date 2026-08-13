import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../utils/helpers/colored_print.dart';

/// TLS certificate pinning for the API host.
///
/// Without pinning, any CA the device trusts can issue a certificate for
/// `api.fat7i.dev` — including a CA an attacker installed on a rooted or
/// managed device — and every request, bearer token included, becomes readable.
///
/// ## Enabling this
///
/// [pinnedSha256Fingerprints] is intentionally EMPTY: pinning is only applied
/// once real fingerprints are listed here. Shipping a wrong pin bricks the app
/// for every user until they install an update, so the values must be read off
/// the live chain rather than guessed.
///
/// Obtain the fingerprint of the certificate you intend to pin:
///
/// ```sh
/// openssl s_client -connect api.fat7i.dev:443 -servername api.fat7i.dev \
///   -showcerts </dev/null 2>/dev/null \
///   | openssl x509 -noout -fingerprint -sha256
/// ```
///
/// Pin the **issuing CA** (Let's Encrypt / ISRG), not the leaf: Caddy renews the
/// leaf roughly every 60 days, and a leaf pin would break the app at each renewal.
/// Always ship at least two pins — the current CA and its announced successor —
/// so a CA rotation does not require an emergency release.
class CertificatePinning {
  const CertificatePinning._();

  /// SHA-256 fingerprints (uppercase hex, colon-separated) of the certificates
  /// that are allowed to terminate TLS for the API host.
  ///
  /// Empty = pinning disabled, platform trust store only (current behaviour).
  static const List<String> pinnedSha256Fingerprints = <String>[
    // 'XX:XX:...:XX', // ISRG Root X1 — fill in after verifying against the live chain
    // 'YY:YY:...:YY', // backup pin (successor CA)
  ];

  static bool get isEnabled => pinnedSha256Fingerprints.isNotEmpty;

  /// Applies pinning to [dio]. A no-op while [pinnedSha256Fingerprints] is empty,
  /// so this is safe to call unconditionally.
  static void apply(Dio dio) {
    if (!isEnabled) {
      if (kDebugMode) {
        printY(
          '[CertificatePinning] Disabled — no pins configured. '
          'See CertificatePinning docs before release.',
          tag: false,
        );
      }
      return;
    }

    final allowed = pinnedSha256Fingerprints
        .map((f) => f.replaceAll(':', '').toUpperCase())
        .toSet();

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();

        // Fires only for chains the platform already rejected. Pinning must not
        // *loosen* validation, so this stays false: an untrusted chain is
        // rejected regardless of whether its fingerprint is pinned.
        client.badCertificateCallback = (cert, host, port) => false;

        return client;
      },
      validateCertificate: (cert, host, port) {
        if (cert == null) return false;

        final fingerprint = _sha256Hex(cert.der);
        final matches = allowed.contains(fingerprint);

        if (!matches) {
          printR(
            '[CertificatePinning] REJECTED $host:$port — fingerprint not pinned.',
            tag: false,
          );
        }

        return matches;
      },
    );
  }

  static String _sha256Hex(List<int> der) => sha256
      .convert(der)
      .bytes
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join()
      .toUpperCase();
}
