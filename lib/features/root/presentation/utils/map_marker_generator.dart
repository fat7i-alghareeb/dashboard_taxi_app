import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Canvas-rendered Google Maps marker icons. Mirrors the customer app's
/// generator (customertaxi/lib/features/root/presentation/utils/map_marker_generator.dart)
/// minus the vehicle PNG loader, which is intentionally omitted because the
/// dashboard app doesn't ship the car asset.
class MapMarkerGenerator {
  MapMarkerGenerator._();

  /// Circular marker with a single character or short label inside.
  /// Used for pickup ("A"), dropoff ("B"), and optionally numbered stops.
  /// When [isEta] is true the text is split into a "number" line on top and
  /// a small label below — handy for ETA pins ("12 min").
  static Future<BitmapDescriptor> createCustomMarker({
    required String text,
    required Color color,
    double size = 40,
    bool isEta = false,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final double radius = size / 2;

    // 1. Soft drop shadow under the pin.
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(Offset(radius, radius + 4), radius - 8, shadowPaint);

    // 2. Filled circle in the requested color.
    final Paint circlePaint = Paint()..color = color;
    canvas.drawCircle(Offset(radius, radius), radius - 8, circlePaint);

    // 3. White border for contrast against the map.
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(radius, radius), radius - 8, borderPaint);

    // 4. Centered text.
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    if (isEta) {
      final parts = text.split(' ');
      final String number = parts.first;
      final String label = parts.length > 1 ? parts.last : '';

      textPainter.text = TextSpan(
        children: [
          TextSpan(
            text: '$number\n',
            style: TextStyle(
              fontSize: size * 0.35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 0.9,
            ),
          ),
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: size * 0.18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ],
      );
    } else {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: size * 0.45,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        radius - (textPainter.width / 2),
        radius - (textPainter.height / 2),
      ),
    );

    final ui.Image image = await pictureRecorder.endRecording().toImage(
          size.toInt(),
          size.toInt(),
        );
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(uint8List);
  }

  /// Pill-shaped label marker with a small tail at the bottom — used for
  /// inline labels on the map (e.g. driver names, route metadata).
  static Future<BitmapDescriptor> createLabelMarker({
    required String text,
    required Color color,
    double height = 38,
    double paddingHorizontal = 12,
  }) async {
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: height * 0.38,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
      ),
    );
    textPainter.layout();

    final double headWidth = textPainter.width + (paddingHorizontal * 2);
    const double tailHeight = 8;
    final double totalHeight = height + tailHeight + 4;
    final double totalWidth = headWidth + 4;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // 1. Shadow.
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final Path shadowPath = Path()
      ..addRRect(RRect.fromLTRBR(
        2,
        2,
        headWidth + 2,
        height + 2,
        Radius.circular(height / 2),
      ))
      ..moveTo(headWidth / 2 - 6 + 2, height + 2)
      ..lineTo(headWidth / 2 + 2, height + tailHeight + 2)
      ..lineTo(headWidth / 2 + 6 + 2, height + 2);
    canvas.drawPath(shadowPath, shadowPaint);

    // 2. Pill body + tail.
    final Paint pinPaint = Paint()..color = color;
    final Path pinPath = Path()
      ..addRRect(RRect.fromLTRBR(
        0,
        0,
        headWidth,
        height,
        Radius.circular(height / 2),
      ))
      ..moveTo(headWidth / 2 - 6, height - 1)
      ..lineTo(headWidth / 2, height + tailHeight)
      ..lineTo(headWidth / 2 + 6, height - 1);
    canvas.drawPath(pinPath, pinPaint);

    // 3. White outline.
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(pinPath, borderPaint);

    // 4. Text.
    textPainter.paint(
      canvas,
      Offset(
        (headWidth - textPainter.width) / 2,
        (height - textPainter.height) / 2,
      ),
    );

    final ui.Image image = await pictureRecorder.endRecording().toImage(
          totalWidth.toInt(),
          totalHeight.toInt(),
        );
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(uint8List);
  }
}
