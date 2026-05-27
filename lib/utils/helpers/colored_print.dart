import 'package:flutter/foundation.dart';

// Blue text
void printB(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[34m$prefix$msg\x1B[0m');
}

// Green text
void printG(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[32m$prefix$msg\x1B[0m');
}

// Yellow text
void printY(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[33m$prefix$msg\x1B[0m');
}

// Red text
void printR(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[31m$prefix$msg\x1B[0m');
}

// white text
void printW(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[37m$prefix$msg\x1B[0m');
}

// cyan text
void printC(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[36m$prefix$msg\x1B[0m');
}

// black text
void printK(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[30m$prefix$msg\x1B[0m');
}

// Additional colors and bright variants
// Magenta text
void printM(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[35m$prefix$msg\x1B[0m');
}

// Light/Bright variants
void printLR(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[91m$prefix$msg\x1B[0m');
}

void printLG(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[92m$prefix$msg\x1B[0m');
}

void printLY(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[93m$prefix$msg\x1B[0m');
}

void printLB(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[94m$prefix$msg\x1B[0m');
}

void printLM(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[95m$prefix$msg\x1B[0m');
}

void printLC(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[96m$prefix$msg\x1B[0m');
}

void printLW(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[97m$prefix$msg\x1B[0m');
}

// Gray (bright black)
void printGray(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[90m$prefix$msg\x1B[0m');
}

void printO(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[38;5;208m$prefix$msg\x1B[0m');
}

void printP(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[38;5;13m$prefix$msg\x1B[0m');
}

void printPink(Object? msg, {bool tag = true}) {
  final prefix = tag ? '[printing] ' : '';
  if (kDebugMode) debugPrint('\x1B[38;5;205m$prefix$msg\x1B[0m');
}
