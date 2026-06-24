import 'dart:io';

final checks = <String, ({RegExp pattern, int baseline})>{
  'inline private classes': (
    pattern: RegExp(r'class\s+_\w+'),
    baseline: 118,
  ),
  'material icons': (pattern: RegExp(r'Icons\.'), baseline: 153),
  'raw EdgeInsets': (pattern: RegExp(r'EdgeInsets\.'), baseline: 170),
  'direct colorScheme access': (
    pattern: RegExp(r'context\.colorScheme'),
    baseline: 21,
  ),
  'raw Flutter buttons': (
    pattern: RegExp(
      r'(?:ElevatedButton|TextButton|OutlinedButton|IconButton)\s*\(',
    ),
    baseline: 12,
  ),
  'raw Scaffold': (pattern: RegExp(r'Scaffold\s*\('), baseline: 3),
};

void main() {
  final dartFiles = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where(
        (file) =>
            file.path.endsWith('.dart') &&
            !file.path.endsWith('.g.dart') &&
            !file.path.endsWith('.freezed.dart'),
      )
      .toList(growable: false);

  var failed = false;
  for (final entry in checks.entries) {
    final count = dartFiles.fold<int>(
      0,
      (total, file) =>
          total + entry.value.pattern.allMatches(file.readAsStringSync()).length,
    );
    stdout.writeln(
      '${entry.key}: $count (non-regression baseline ${entry.value.baseline})',
    );
    if (count > entry.value.baseline) {
      stderr.writeln('Architecture regression: ${entry.key} increased.');
      failed = true;
    }
  }

  if (failed) exitCode = 1;
}
